require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class SoarScServiceRegistryOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
      end




      def given_a_valid_service_registry_uri
        @iut.environment['SERVICE_REGISTRY'] = 'http://service-registry.auto-h.net:8080'
      end

      def given_a_service_registry_client_provider
        credentials = { 'username' => 'uddi', 'password' => 'uddi' }
      end

      def given_no_service_registry_client_provider
        #break the configuration that will result in no service registry client provider
        @iut.configuration['service_registry']['freshness'] = 'not_a_number'
      end

      def given_a_service_registry_client_initialization_failure
        #initialization failure by creating an incorrect configuration
        @iut.configuration['service_registry']['freshness'] = 'not_a_number'
      end

      def given_a_request_for_a_service
      end

      def given_a_policy_for_the_service_exists
      end

      def given_the_policy_is_registered_with_the_service
      end

      def given_a_policy_for_the_service_does_not_exists
      end

      def given_the_policy_is_not_registered_with_the_service
      end

      def given_a_failure
      end


      def when_determining_authorization_for_the_service
        bootstrap #bootstrap will result in the configuration being picked up before any other testing

        puts "TODO - Pending implementation"
      end

      def i_have_an_initialized_service_registry_client
        false
      end

      def the_client_has_the_full_suite_of_service_registry_functionality
        false
      end

      def i_ask_the_service_registry_for_the_service_policy_name
        false
      end

      private

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Service registry client providing full suite of service registry functionality", ServiceComponent::Test::SoarScServiceRegistryOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Policy lookup",                                                                  ServiceComponent::Test::SoarScServiceRegistryOrchestrationProvider)
