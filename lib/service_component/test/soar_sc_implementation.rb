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
        @std_out_err_file = "#{ENV['SOAR_DIR']}/webrick.rackup.stdout"

        @environment_file = "#{ENV['SOAR_DIR']}/config/environment.yml"
        @environment = load_file(@environment_file)
        @original_environment = load_yaml_file(@environment_file)

        @configuration_file = "#{ENV['SOAR_DIR']}/config/config.yml"
        @configuration = load_yaml_file(@configuration_file)
        @original_configuration = load_yaml_file(@configuration_file)


        @identifier = environment['IDENTIFIER']

        @audit_events_file = "#{ENV['SOAR_DIR']}/#{@configuration['auditing']['auditors']['log4r']['file_name']}"
      end

      def identify(identifier)
        @identifier = identifier
      end

      def clear_messages
        File.delete(@std_out_err_file) rescue nil
        `touch #{@std_out_err_file}`
      end

      def has_sent_notification?(message)
        found = `grep '#{message}' #{@std_out_err_file}`
        found.size > 0
      end

      def get_latest_audit_entries(lines = 1)
        `tail -n #{lines} #{@audit_events_file}`
      end

      def bootstrap(environment)
        #environment['IDENTIFIER'] = @identifier
        soar_dir = ENV['SOAR_DIR']
        puts "NOTE: Run keep_running.sh in #{soar_dir} using SOAR_TECH=rackup"
        if (soar_dir.nil?) or (soar_dir.strip == '')
          puts "SOAR_DIR not defined"
          return
        end
        bootstrap_with_environment(environment, @environment_file)
        bootstrap_with_configuration(@configuration,@configuration_file)

        `cd #{soar_dir}&&./stop.sh`
        detail = get_status_detail
        return fail if detail.nil?
        success_data(detail)
      end

      def get_status_detail
        success = false
        attempts = 1
        threshold = 5
        response = nil
        while (not success) and (attempts <= threshold) do
          begin
            printf "!"
            status_detail_uri = 'http://localhost:9393/status-detail'
            response = Net::HTTP.get(URI.parse(status_detail_uri))
            success = true
          rescue
            success = false
            sleep 1
            attempts = attempts + 1
          end
        end

        #restore environment and configuration which needs a pause for it to be loaded
        restore_configuration
        restore_environment
        sleep 2

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
        YAML.load_file(file_name)
      end

      def load_file(file_name)
        if File.exist?(file_name)
          stringify_values(YAML.load_file(file_name))
        else
          {}
        end
      rescue IOError, SystemCallError, Psych::Exception => ex
        raise LoadError.new("Failed to load environment #{file_name} : #{ex}")
      end

      def stringify_values(hash)
        Hash[hash.map{ |k, v| [k, v.to_s] }]
      end
    end
  end
end
