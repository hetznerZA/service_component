require 'json'
require 'yaml'
require 'jsender'

module ServiceComponent
  module Test
    class SoarScImplementation
      USER     = 'dev' unless defined? USER;     USER.freeze
      PASSWORD = 'dev' unless defined? PASSWORD; PASSWORD.freeze

      include Jsender

      attr_reader :uri
      attr_reader :identifier
      attr_accessor :environment
      attr_accessor :configuration
      attr_accessor :configuration_file
      attr_accessor :environment_example_file
      attr_accessor :environment_file
      attr_reader :username
      attr_reader :password
      attr_reader :smaak_client_psk

      def initialize(uri)
        @uri = uri
        @std_out_err_file = "#{ENV['SOAR_DIR']}/soar_sc.log"

        @desired_execution_environment = 'development'

        @environment_example_file = "#{ENV['SOAR_DIR']}/config/environment.yml.example"
        @environment_file = "#{ENV['SOAR_DIR']}/config/environment.yml"
        @environment = load_yaml_file(@environment_example_file)
        @original_environment = load_yaml_file(@environment_example_file)
        @environment.delete('CAS_SERVER')
        @original_environment.delete('CAS_SERVER')
        @environment['BASIC_AUTH_USER'] = USER
        @environment['BASIC_AUTH_PASSWORD'] = PASSWORD

        @configuration_file = "#{ENV['SOAR_DIR']}/config/config.yml"
        @configuration = load_yaml_file(@configuration_file)
        @configuration['auditing'] = {'auditors' => {'log4r' => {'file_name' => 'soar_sc_audit_file.log'}}}
        @original_configuration = load_yaml_file(@configuration_file)

        @audit_events_file = "#{ENV['SOAR_DIR']}/soar_sc.log"


        @smaak_client_psk = get_strong_password
        configure_smaak_server_with_test_orchestration_client
      end

      def environment_can_be_loaded_from_system_process?
        require 'json'
        result = `curl http://soar-ci.dev.auto-h.net:8080/view/SOAR/job/soar-environment/api/json?pretty=true`
        data = JSON.parse(result)
        url = data['builds'].first['url'] + "api/json?pretty=true"
        result = `curl #{url}`
        data = JSON.parse(result)
        data['result'] == "SUCCESS"
      end

      def load_environment_file
        @environment = load_file(@environment_file)
      end

      def load_configuration_file
        @configuration = load_yaml_file(@configuration_file)
      end

      def clear_messages
        File.delete(@std_out_err_file) rescue nil
        `touch #{@std_out_err_file}`
      end

      def has_sent_notification?(message)
        found = `grep '#{message}' #{@std_out_err_file}`
        found.size > 0
      end

      def get_latest_test_orchestrator_audit_entry(test_lines = 1)
        `tail -n 100 #{@audit_events_file} | grep 'TEST_ORCHESTRATOR' | tail -#{test_lines}`
      end

      def has_audit_entry_with_message_and_flow_id?(message,flow_id)
        BaseOrchestrationProvider::busy_wait(4,true) {
          lines = get_audit_entries_with_flow_id(flow_id)
          lines.include?(message)
        }
      end

      def get_audit_entries_with_flow_id(flow_id)
        `tail -n 100 #{@audit_events_file} | grep '#{flow_id}'`
      end

      def audit_entry_with_message_exist?(message)
        BaseOrchestrationProvider::busy_wait(4,true) {
          grep_result = `tail -n 100 #{@audit_events_file} | grep '#{message}'`
          grep_result.length > 0
        }
      end

      #Specializations for SOAR_SC

      def given_no_auditing_level
        puts "Missing audit levels are not testable at the moment, defaulting to debug"
      end

      def given_no_service_registry_client_provider
        puts "unable to test this in soar_sc since it is always available, forcing failure via an initilization failure"
        @environment['SERVICE_REGISTRY'] = 'not\a\uri'
      end

      def given_an_authorization_provider_initialization_failure
        puts "Unable to test this at present in soar sc directly, simulate it indirectly by disabling the service registry on which authorization depends"
        @environment['SERVICE_REGISTRY'] = 'not\a\uri'
      end

      def has_received_notification_for_missing_auditor_configuration?
        #Untestable in SOAR_SC implementation due to the default auditor configuration
        #being supplied in the event that the configuration is not present.
        true
      end

      def has_received_notification_for_missing_auditing_configuration?
        #Untestable in SOAR_SC implementation due to the default auditor configuration
        #being supplied in the event that the configuration is not present.
        true
      end

      def have_responded_with_no_authenticated_identity?
        #Untestable in SOAR_SC implementation due to no authenticated routes being matched
        #if the identity could not complete authentication.
        true
      end

      def have_responded_with_the_authenticated_identity_identifier_in_request_not_requiring_authentication?
        #Untestable in unauthenticated router
        true
      end

      def have_notified_of_a_failure_determining_authentication_identity?
        #Untestable in authenticated router
        true
      end




      def force_failure_reading_the_environment_file
        @force_failure_reading_the_environment_file = true
      end

      def force_failure_reading_the_configuration_file
        @force_failure_reading_the_configuration_file = true
      end

      def force_invalid_configuration_file
        @force_invalid_configuration_file = true
      end

      def set_execution_environment(execution_environment)
        @desired_execution_environment = execution_environment
      end

      def remove_execution_environment
        File.delete("#{ENV['SOAR_DIR']}/keep_running_execution_environment") rescue nil
      end

      def bootstrap
        soar_dir = ENV['SOAR_DIR']
        puts "NOTE: Run keep_running.sh in #{soar_dir} using SOAR_TECH=rackup"
        if (soar_dir.nil?) or (soar_dir.strip == '')
          puts "SOAR_DIR not defined"
          return
        end

        `echo '#{@desired_execution_environment}' > #{ENV['SOAR_DIR']}/keep_running_execution_environment`

        if @force_failure_reading_the_environment_file
          File.delete(@environment_file) rescue nil
          `echo 'junk' > #{@environment_file}`
          @force_failure_reading_the_environment_file = false
        else
          bootstrap_with_environment(@environment, @environment_file)
        end

        if @force_invalid_configuration_file
          File.delete(@configuration_file) rescue nil
          `echo 'junk' > #{@configuration_file}`
          @force_invalid_configuration_file = false
        else
          bootstrap_with_configuration(@configuration,@configuration_file)
        end

        `cd #{soar_dir}&&./stop.sh`
        detail = get_status_detail

        #after we got the status detail we know the service is running. Now we restore_configuration
        #the environment and configuration files to be ready for the next test.
        restore_configuration
        restore_environment
        remove_execution_environment

        return fail if detail.nil?
        success_data(detail)
      end

      def get_status_detail
        status_detail_uri = "#{@uri}/status-detail"
        response = nil

        success = BaseOrchestrationProvider::busy_wait(4,true) {
          begin
            printf "!"
            response = query_endpoint(resource: 'status-detail')
            printf "Error response code #{response.code}" unless response.code.to_s == '200'
            true
          rescue
            false
          end
        }
        printf "\n"
        return nil if not success
        JSON.parse(response.body)
      end

      def attempt_graceful_shutdown

        puts `ps aux | grep rackup | grep -v grep`

        puts 'Sending kill signal'
        `KILL_SIGNAL=INT #{ENV['SOAR_DIR']}/stop.sh`

        success = BaseOrchestrationProvider::busy_wait(10,true) {
          rackup_processes = `ps aux | grep rackup | grep -v grep | tr -s ' ' ' ' | cut -d ' ' -f2`
          0 == rackup_processes.length
        }

        puts 'Graceful shutdown complete' if success

        #Shutdown forcibly if this failed.
        if not success
          puts 'Unable to gracefully shutdown, do it forcibly'
          `KILL_SIGNAL=9 #{ENV['SOAR_DIR']}/stop.sh`
        end
      end

      def query_endpoint(resource: '/', parameters: {}, user: USER, password: PASSWORD, cookie: nil)
        require 'uri'
        require 'net/http'
        uri = URI.parse("#{@uri}/#{resource}")
        uri.query = URI.encode_www_form( parameters )
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth(user, password) if user
        request['Cookie'] = cookie if cookie
        http.request(request)
      end

      def restore_configuration
        bootstrap_with_configuration(@original_configuration,@configuration_file)
      end

      def restore_environment
        bootstrap_with_environment(@original_environment,@environment_file)
      end

      def bootstrap_with_environment(environment, environment_file)
        File.delete(environment_file) rescue nil
        File.open(environment_file, 'w') { |f| f.write environment.to_yaml }
      end

      def bootstrap_with_configuration(configuration, configuration_file)
        File.delete(configuration_file) rescue nil
        File.open(configuration_file, 'w') { |f| f.write configuration.to_yaml }
      end

      def configure_smaak_server_with_test_orchestration_client
        server_key_material = load_yaml_file("#{ENV['SOAR_DIR']}/smaak/server.yml")
        @configuration['public_key']  = server_key_material['public_key']
        @configuration['private_key'] = server_key_material['private_key']

        client_key_material = load_yaml_file("#{ENV['SOAR_DIR']}/smaak/client.yml")
        @configuration['associations'] =
          {
            'service-client.dev.auto-h.net' => {
              'public_key' => client_key_material['public_key'],
              'psk' => @smaak_client_psk,
              'encrypted' => false
            }
          }
      end

      def load_yaml_file(file_name)
        begin
          if File.exist?(file_name)
            YAML.load_file(file_name)
          else
            {}
          end
        rescue IOError, SystemCallError, Psych::Exception => ex
          raise LoadError.new("Failed to load yaml file #{file_name} : #{ex}")
        end
      end

      def get_strong_password
        require 'uri'
        require 'net/http'
        uri = URI.parse("https://credential-policy-validator.auto-h.net/generate-credential?policy=hetzner-strong-passwords")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.is_a?(URI::HTTPS)
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        JSON.parse(response.body)['data']['credential']
      end
    end
  end
end
