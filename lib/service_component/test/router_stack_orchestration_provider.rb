require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class RouterStackOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
      end

      def given_a_request_for_a_service_that_match_multiple_controllers
        @service_endpoint_name = 'routing-tests/endpoint-with-multiple-controllers'
      end

      def given_a_request_for_a_service_that_matches_one_controller
        @service_endpoint_name = 'routing-tests/endpoint-with-one-controller'
      end

      def given_a_request_for_a_service_with_rest_parametrized_resource
        @service_endpoint_name = 'routing-tests/endpoint-with-rest-parametrized-resource'
        @rest_test_parameter = true
      end

      def given_a_request_for_a_service_that_matches_no_controller
        @service_endpoint_name = 'routing-tests/endpoint-with-no-controller'
      end

      def given_no_controller_matches_the_request_directly
        @service_endpoint_name = 'routing-tests/no-registered-controller-endpoint-with-rest-parametrized-resource'
      end

      def receive_a_request
        @test_flow_id = create_unique_id
        parameters = { :flow_identifier => @test_flow_id }
        @service_endpoint_name = "#{@service_endpoint_name}/1234" if @rest_test_parameter
        @iut.query_endpoint(resource: @service_endpoint_name, parameters: parameters)
      end



      def has_attempted_to_matched_the_path_to_registered_controllers?
        return true if @iut.has_audit_entry_with_message_and_flow_id?('RoutingTestFirstController',@test_flow_id)
        entries = @iut.get_audit_entries_with_flow_id(@test_flow_id)
        entries.include?('RoutingTestSecondController') or entries.include?('no match')
      end

      def has_called_the_controller_that_match_best?
        @iut.has_audit_entry_with_message_and_flow_id?('RoutingTestFirstController',@test_flow_id)
      end

      def has_matched_the_path_to_the_controller?
        @iut.has_audit_entry_with_message_and_flow_id?('RoutingTestFirstController',@test_flow_id)
      end

      def has_matched_the_path_to_registered_controllers?
        @iut.has_audit_entry_with_message_and_flow_id?('RoutingTestFirstController',@test_flow_id)
      end

      def has_called_the_controller?
        @iut.has_audit_entry_with_message_and_flow_id?('RoutingTestFirstController',@test_flow_id)
      end

      def has_not_called_a_controller?
        @iut.has_audit_entry_with_message_and_flow_id?('no match',@test_flow_id)
      end

      def has_not_excluded_parametrized_resource_matching_in_the_design?
        @iut.has_audit_entry_with_message_and_flow_id?('/1234',@test_flow_id)
      end

      private

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Verifying signed requests",       ServiceComponent::Test::RouterStackOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Routing stack",                   ServiceComponent::Test::RouterStackOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Routing requests to controllers", ServiceComponent::Test::RouterStackOrchestrationProvider)
