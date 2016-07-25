require 'json'
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
        #implicit since by default there will be a service registry client provider
      end

      def given_no_service_registry_client_provider
        remove_service_registry_client
      end

      def given_a_service_registry_client_initialization_failure
        #initialization failure by creating an incorrect configuration
        @iut.environment['SERVICE_REGISTRY'] = 'not\a\uri'
      end

      def given_a_request_for_a_service
        #request is setup as a collection of other aspects right before the request.
        @test_id = create_unique_id
      end

      def given_a_policy_for_the_service_exists
        @policy_existance_state = 'existing'
      end

      def given_the_policy_is_registered_with_the_service
        @policy_registration_state = 'registered'
      end

      def given_a_policy_for_the_service_does_not_exists
        @policy_existance_state = 'nonexisting'
      end

      def given_the_policy_is_not_registered_with_the_service
        @policy_registration_state = 'unregistered'
      end

      def given_a_failure
        #simulate a failure by setting the policy we will use to a nonexisting entry
        @policy_existance_state = 'nonexisting'
      end


      def determine_authorization_for_the_service
        @test_service = "architectural-test-service-with-#{@policy_registration_state}-#{@policy_existance_state}-policy"
        bootstrap
        hit_endpoint_requiring_authorization(@test_service,@test_id)
      end

      def has_an_initialized_service_registry_client
        @iut.has_audit_entry_with_message_and_flow_id?('Using registry at',get_startup_flow_identifier)
      end

      def the_client_has_the_full_suite_of_service_registry_functionality
        @iut.has_audit_entry_with_message_and_flow_id?('Using registry at',get_startup_flow_identifier)
      end

      def has_asked_the_service_registry_for_the_service_policy_name
        #We know that the soar_sc instance reached out or attempted to reach out to the service registry
        #if any of the following error notifications occurred or if the policy itself was requested successfully
        @iut.has_audit_entry_with_message_and_flow_id?('Could not find policy',@test_id) ||
        @iut.has_audit_entry_with_message_and_flow_id?('No policy associated with service',@test_id) ||
        @iut.has_audit_entry_with_message_and_flow_id?('Could not retrieve policy for service',@test_id) ||
        query_last_flow_identifier_from_policy == @test_id
      end

      private

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

      def remove_service_registry_client
        parameters = { :operation => 'remove-service-registry-client' }
        @iut.query_endpoint(resource: 'service-registry-client-controller',parameters: parameters)
      end

      def query_last_flow_identifier_from_policy
        result = JSON.parse(@iut.query_endpoint(resource: 'authorization-policy-is-anyone/get_latest_flow_identifier', parameters: {}).body)
        result['last_flow_identifier']
      end

      def hit_endpoint_requiring_authorization(test_service,test_id)
        @iut.query_endpoint(resource: test_service, parameters: { :flow_identifier => test_id })
      end

      def create_unique_id
        "#{SecureRandom.hex(32)}"
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Service registry client providing full suite of service registry functionality", ServiceComponent::Test::SoarScServiceRegistryOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Policy lookup",                                                                  ServiceComponent::Test::SoarScServiceRegistryOrchestrationProvider)
