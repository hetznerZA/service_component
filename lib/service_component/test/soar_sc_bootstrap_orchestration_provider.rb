module ServiceComponent
  module Test
    class SoarScBootstrapOrchestrationProvider < BootstrapOrchestrationProvider
      def given_environment_can_be_loaded_from_system_process
        @iut.environment_can_be_loaded_from_system_process?
      end

      def given_environment_configuration
        # default valid environment provided from the environment.yml file and loaded implicitly
      end

      def given_an_environment
        # default valid environment provided from the environment.yml file and loaded implicitly
      end

      def given_a_service_identifier_present_in_the_environment
        given_valid_service_identifier_in_environment_file
      end

      def given_a_service_registry_uri_present_in_the_environment
        given_a_service_registry_uri_present_in_the_environment_file
      end

      def given_an_authentication_service_uri_present_in_the_environment
        given_an_authentication_service_uri_present_in_the_environment_file
      end

      def given_an_execution_environment_indicator_present_in_the_environment
        given_an_execution_environment_indicator_present_in_the_environment_file
      end

      def given_a_configuration_service_uri_present_in_the_environment
        given_a_configuration_service_uri_present_in_the_environment_file
      end

      def given_a_configuration_service_token_present_in_the_environment
        given_a_configuration_service_token_present_in_the_environment_file
      end

      def given_a_configuration_service_provider_present_in_the_environment
        given_a_configuration_service_provider_present_in_the_environment_file
      end

      def given_a_valid_session_key_in_environment
        given_a_valid_session_key_in_environment_file
      end

      def given_a_session_secret_in_environment
        given_a_session_secret_in_environment_file
      end



      def given_an_environment_file
        @iut.environment_example_file = "#{ENV['SOAR_DIR']}/config/environment.yml.example"
      end

      def given_the_environment_file_is_placed_in_an_expected_location
        @iut.environment_file = "#{ENV['SOAR_DIR']}/config/environment.yml"
      end

      def given_a_service_registry_uri_present_in_the_environment_file
        @iut.environment['SERVICE_REGISTRY'] = 'http://service-registry.auto-h.net:8080'
      end

      def given_an_authentication_service_uri_present_in_the_environment_file
        @iut.environment['CAS_SERVER'] = 'https://login.konsoleh.co.za/cas'
      end

      def given_an_execution_environment_indicator_present_in_the_environment_file
        @iut.environment['RACK_ENV'] = 'development'
      end

      def given_a_configuration_service_uri_present_in_the_environment_file
        @iut.environment['CFGSRV_PROVIDER_ADDRESS'] = 'https://vault.auto-h.net'
      end

      def given_a_configuration_service_token_present_in_the_environment_file
        @iut.environment['CFGSRV_TOKEN'] = 'TOKEN'
      end

      def given_a_configuration_service_provider_present_in_the_environment_file
        @iut.environment['CFGSRV_PROVIDER'] = 'vault'
      end

      def given_a_failure_reading_the_environment_file
        @iut.force_failure_reading_the_environment_file
      end

      def given_sessions_use_is_undefined
        @iut.environment['USE_SESSIONS'] = nil
      end

      def given_sessions_use_is_invalid
        @iut.environment['USE_SESSIONS'] = 'notrueorfalse'
      end

      def given_sessions_are_not_used
        @iut.environment['USE_SESSIONS'] = 'false'
      end

      def given_sessions_are_used
        @iut.environment['USE_SESSIONS'] = 'true'
      end

      def given_no_session_key
        @iut.environment['SESSION_KEY'] = nil
      end

      def given_no_session_secret
        @iut.environment['SESSION_SECRET'] = nil
      end

      def given_session_key_is_invalid
        @iut.environment['SESSION_KEY'] = 'something_with_()_which_is_invalid'
      end

      def given_session_secret_is_invalid
        @iut.environment['SESSION_SECRET'] = 'too_short'
      end

      def given_a_session_secret_in_environment_file
        @iut.environment['SESSION_SECRET'] = "#{SecureRandom.hex(16)}" #create 32 byte secret string
      end

      def given_a_valid_session_key_in_environment_file
        @iut.environment['SESSION_KEY'] = 'a_unique_session_key_for_testing'
      end

      def given_a_valid_an_execution_environment_indicator
        @iut.environment['RACK_ENV'] = 'debug'
      end

      def given_an_invalid_execution_environment_indicator
        @iut.environment['RACK_ENV'] = 'strange_environment'
      end

      def given_no_execution_environment_indicator
        @iut.environment['RACK_ENV'] = nil
      end

      def has_remembered_the_execution_environment_indicator
        can_extract_the_execution_environment_indicator_from_the_environment_file
      end

      def can_extract_the_service_identifier_from_the_environment
        can_extract_the_service_identifier_from_the_environment_file
      end

      def can_extract_the_service_registry_uri_from_the_environment
        can_extract_the_service_registry_uri_from_the_environment_file
      end

      def can_extract_the_authentication_service_uri_from_the_environment
        can_extract_the_authentication_service_uri_from_the_environment_file
      end

      def can_extract_the_execution_environment_indicator_from_the_environment
        can_extract_the_execution_environment_indicator_from_the_environment_file
      end

      def can_extract_the_configuration_service_uri_from_the_environment
        can_extract_the_configuration_service_uri_from_the_environment_file
      end

      def can_extract_the_configuration_service_token_from_the_environment
        can_extract_the_configuration_service_token_from_the_environment_file
      end

      def can_extract_the_configuration_service_provider_from_the_environment
        can_extract_the_configuration_service_provider_from_the_environment_file
      end

      def can_extract_the_session_key_from_the_environment
        can_extract_the_session_key_from_the_environment_file
      end

      def can_extract_the_session_secret_from_the_environment
        can_extract_the_session_secret_from_the_environment_file
      end

      def can_extract_the_service_identifier_from_the_environment_file
        @iut.environment['IDENTIFIER'] == @bootstrap_status['data']['environment']['IDENTIFIER']
      end

      def can_extract_the_service_registry_uri_from_the_environment_file
        @iut.environment['SERVICE_REGISTRY'] == @bootstrap_status['data']['environment']['SERVICE_REGISTRY']
      end

      def can_extract_the_authentication_service_uri_from_the_environment_file
        @iut.environment['CAS_SERVER'] == @bootstrap_status['data']['environment']['CAS_SERVER']
      end

      def can_extract_the_execution_environment_indicator_from_the_environment_file
        'debug' == @bootstrap_status['data']['environment']['RACK_ENV']
      end

      def can_extract_the_configuration_service_uri_from_the_environment_file
        @iut.environment['CFGSRV_PROVIDER_ADDRESS'] == @bootstrap_status['data']['environment']['CFGSRV_PROVIDER_ADDRESS']
      end

      def can_extract_the_configuration_service_token_from_the_environment_file
        '********' == @bootstrap_status['data']['environment']['CFGSRV_TOKEN']
      end

      def can_extract_the_configuration_service_provider_from_the_environment_file
        @iut.environment['CFGSRV_PROVIDER'] == @bootstrap_status['data']['environment']['CFGSRV_PROVIDER']
      end

      def can_extract_the_session_key_from_the_environment_file
        '********' == @bootstrap_status['data']['environment']['SESSION_KEY']
      end

      def can_extract_the_session_secret_from_the_environment_file
        '********' == @bootstrap_status['data']['environment']['SESSION_SECRET']
      end

      def has_received_notification?(message)
        return true if super(message)
        @iut.has_sent_notification?(message)
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with a service identifier", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with CORS configuration", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Ensuring CORS configuration applies", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with environment configuration file", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with environment configuration", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with an execution environment indicator", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("production", "Bootstrapping with a service identifier", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("production", "Bootstrapping with CORS configuration", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("production", "Ensuring CORS configuration applies", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
