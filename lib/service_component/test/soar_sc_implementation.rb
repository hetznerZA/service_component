require 'json'
require 'yaml'
require 'jsender'

module ServiceComponent
  module Test
    class SoarScImplementation
      include Jsender

      attr_reader :uri
      attr_reader :identifier
      attr_accessor :environment
      attr_accessor :configuration

      def initialize(uri)
        @uri = uri
        @std_out_err_file = "#{ENV['SOAR_DIR']}/soar_sc.log"

        @environment_example_file = "#{ENV['SOAR_DIR']}/config/environment.yml.example"
        @environment_file = "#{ENV['SOAR_DIR']}/config/environment.yml"
        @environment = load_yaml_file(@environment_example_file)
        @original_environment = load_yaml_file(@environment_example_file)

        @configuration_file = "#{ENV['SOAR_DIR']}/config/config.yml"
        @configuration = get_status_detail['configuration']
        @original_configuration = get_status_detail['configuration']

        @audit_events_file = "#{ENV['SOAR_DIR']}/#{@configuration['auditing']['auditors']['log4r']['file_name']}"
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

      def bootstrap
        soar_dir = ENV['SOAR_DIR']
        puts "NOTE: Run keep_running.sh in #{soar_dir} using SOAR_TECH=rackup"
        if (soar_dir.nil?) or (soar_dir.strip == '')
          puts "SOAR_DIR not defined"
          return
        end
        bootstrap_with_environment(@environment, @environment_file)
        bootstrap_with_configuration(@configuration,@configuration_file)

        `cd #{soar_dir}&&./stop.sh`
        detail = get_status_detail
        return fail if detail.nil?
        success_data(detail)
      end

      def get_status_detail
        status_detail_uri = "#{@uri}/status-detail"
        response = nil

        success = BaseOrchestrationProvider::busy_wait(5,true) {
          begin
            printf "!"
            response = Net::HTTP.get(URI.parse(status_detail_uri))
            true
          rescue
            false
          end
        }
        printf "\n"

        #restore environment and configuration which needs a busy-wait pause
        #to ensure the restoration is complete before continuing
        restore_configuration
        restore_environment
        BaseOrchestrationProvider::busy_wait(5,true) {
          begin
            printf "!"
            Net::HTTP.get(URI.parse(status_detail_uri))
            true
          rescue
            false
          end
        }

        return nil if not success
        JSON.parse(response)
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

      def load_yaml_file(file_name)
        begin
          if File.exist?(file_name)
            YAML.load_file(file_name)
          else
            {}
          end
        rescue IOError, SystemCallError, Psych::Exception => ex
          raise LoadError.new("Failed to load environment #{file_name} : #{ex}")
        end
      end
    end
  end
end
