require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class ParameterValidationOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
      end

      def given_request_with_valid_parameters
        @request_parmeters = { 'some_required_parameter' => 'valid_parameter_string' }
      end

      def given_request_with_invalid_parameters
        @request_parmeters = { } #missing parameter
      end

      def given_a_routing_that_does_not_specify_parameters
        @service_endpoint_name = "/parameter-validation-test-no-parameters-specified"
      end

      def given_a_routing_that_specify_nonrequired_parameters
        @service_endpoint_name = "/parameter-validation-test-nonrequired-parameters-specified"
      end

      def given_a_routing_that_specify_required_parameters
        @service_endpoint_name = "/parameter-validation-test-required-parameters-specified"
      end

      def receive_a_request
        @test_flow_id = create_unique_id
        parameters = { :flow_identifier => @test_flow_id }
        @response = @iut.query_endpoint(resource: @service_endpoint_name, parameters: @request_parmeters)
      end

      def request_was_allowed_to_be_routed_to_controller?
        @response.code == "200"
      end

      def request_was_rejected_due_to_invalid_request_parameters?
        @response.code == "400"
      end

      private

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Validating request parameters", ServiceComponent::Test::ParameterValidationOrchestrationProvider)
