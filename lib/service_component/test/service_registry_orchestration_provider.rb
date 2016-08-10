require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

class Hash
  def grep(pattern)
    inject([]) do |res, kv|
      res << kv if kv[0] =~ pattern or kv[1] =~ pattern
      res
    end
  end
end

module ServiceComponent
  module Test
    class SoarScServiceRegistryOrchestrationProvider < SoarScBootstrapOrchestrationProvider
      FIRST_ACCESS_POINT     = 'http://localhost:9393/architectural-test-service-access-point-1/'              unless defined? FIRST_ACCESS_POINT;     FIRST_ACCESS_POINT.freeze
      SECOND_ACCESS_POINT    = 'http://localhost:9393/architectural-test-service-access-point-2/'              unless defined? SECOND_ACCESS_POINT;    SECOND_ACCESS_POINT.freeze
      UNREACHED_ACCESS_POINT = 'http://unreachable:9393/architectural-test-service-access-point-unreachable/'  unless defined? UNREACHED_ACCESS_POINT; UNREACHED_ACCESS_POINT.freeze
      def setup
        super
        @iut.set_execution_environment('production')
        bootstrap
      end

      def given_a_service_registry_client_provider
        #implicit since by default there will be a service registry client provider
      end

      def given_no_service_registry_client_provider
        puts "unable to test this in soar_sc since it is always available, forcing failure via an initilization failure"
        given_a_service_registry_client_initialization_failure
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

      def given_a_service_name
        @request_service_name = 'architectural-test-service'
      end

      def given_the_service_is_registered_in_the_service_registry
        @request_service_registered_in_service_registry = '-registered'
      end

      def given_the_service_is_not_registered_in_the_service_registry
        @request_service_registered_in_service_registry = '-unregistered'
      end

      def given_no_access_points_for_that_service_in_the_service_registry
        @request_service_access_point_count = '-with-0-uris'
      end

      def given_the_service_has_access_points_registered_in_the_service_registry
        @request_service_access_point_count = '-with-1-uris'
      end

      def given_the_service_has_multiple_access_points_registered_in_the_service_registry
        @request_service_access_point_count = '-with-2-uris'
      end

      def given_i_have_cached_the_answer_before
        ask_for_service_uri('find_first_service_uri')
      end

      def given_i_have_not_cached_the_answer_before
        #implicit. Simply do not do request and it wont be cached.
      end

      def given_a_service_registry_failure
        #Modify the uri inside the service registry to point to an invalid service registry uri.  All future requests will fail.
        create_failure_in_service_registry_client
      end

      def given_some_of_the_access_points_are_unreachable
        @request_service_with_some_access_point_unreachable = '-some-unreachable'
      end





      def determine_authorization_for_the_service
        @test_service = "architectural-test-service-with-#{@policy_registration_state}-#{@policy_existance_state}-policy"
        bootstrap
        hit_endpoint_requiring_authorization(@test_service,@test_id)
      end

      def find_service_uris_for_the_service
        ask_for_service_uri('find_first_service_uri')
      end

      def find_best_service_uris_for_the_service
        ask_for_service_uri('find_best_service_uri')
      end

      def ask_for_service_uri(mode)
        @test_search_for_service = build_service_name_for_test_search
        parameters = { :operation => mode,
                       :service   => @test_search_for_service }
        start_time = Time.now
        @service_registry_query_result = @iut.query_endpoint(resource: 'service-registry-client-command-and-control', parameters: parameters)
        @query_answer_time = Time.now - start_time
        @service_registry_query_result = JSON.parse(@service_registry_query_result.body)
      end

      def build_service_name_for_test_search
        "#{@request_service_name}#{@request_service_registered_in_service_registry}#{@request_service_access_point_count}#{@request_service_with_some_access_point_unreachable}"
      end

      def has_asked_the_service_registry_for_access_points_for_the_service
        @service_registry_query_result['service_registry_meta']['cache_key_value_pairs'].to_s.include?('architectural-test-service') or
        @service_registry_query_result['service_registry_response'].nil? #Not a great test but we will get a nil from service registry if nothing is found
      end

      def has_cached_the_first_service_uris_in_in_the_list_of_acccess_points
        @service_registry_query_result['service_registry_meta']['cache_key_value_pairs']['find_services:%architectural-test-service-registered-with-1-uris%']['data']['services']['architectural-test-service-registered-with-1-uris']['uris'].to_s.include?(FIRST_ACCESS_POINT)
      end

      def has_returned_the_first_service_uris_in_the_list_of_access_points_the_service_registry_returns
        FIRST_ACCESS_POINT == @service_registry_query_result['service_registry_response']
      end

      def has_cached_nil
        @service_registry_query_result['service_registry_meta']['cache_key_value_pairs'].grep(/service_uris.*/)[0][1]['data']['bindings'].empty?
        #print(@service_registry_query_result['service_registry_meta']['cache_key_value_pairs'].to_yaml)
      end

      def has_returned_nil
        @service_registry_query_result['service_registry_response'].nil?
      end

      def has_not_cached_nil
        return true if @service_registry_query_result['service_registry_meta']['cache_key_value_pairs'].grep(/service_uris.*/).empty?
        return true if @service_registry_query_result['service_registry_meta']['cache_key_value_pairs'].grep(/service_uris.*/)[0][1]['data']['bindings'].empty?
        false
      end

      def has_returned_cached_value
        returned_value = @service_registry_query_result['service_registry_response']
        (FIRST_ACCESS_POINT == returned_value) and
        (@service_registry_query_result['service_registry_meta']['cache_key_value_pairs'].to_s.include?(returned_value))
      end

      def has_asked_the_services_for_their_functional_status
        audit_entry_with_message_exist?('matched /status')
      end

      def has_returned_the_service_uri_for_which_the_best_functional_status_was_obtained
        FIRST_ACCESS_POINT == @service_registry_query_result['service_registry_response'] or
        SECOND_ACCESS_POINT == @service_registry_query_result['service_registry_response']
      end

      def has_not_cached
        @service_registry_query_result['service_registry_meta']['cache_key_value_pairs'].grep(/service_uris.*/).empty?
      end

      def has_not_updated_the_cache_based_on_functional_status
        #Make sure we did not lose the unreachable access point.
        @service_registry_query_result['service_registry_meta']['cache_key_value_pairs'].to_s.include?(UNREACHED_ACCESS_POINT)
      end

      def has_answered_in_less_than(time_in_seconds)
        @query_answer_time < time_in_seconds.to_i
      end

      def has_an_initialized_service_registry_client
        @iut.has_audit_entry_with_message_and_flow_id?('Using registry at',get_startup_flow_identifier)
      end

      def the_client_has_the_full_suite_of_service_registry_functionality
        @iut.has_audit_entry_with_message_and_flow_id?('Using registry at',get_startup_flow_identifier)
      end

      def has_asked_the_service_registry_for_the_service_policy_name
        busy_wait(2,true) {
          #We know that the soar_sc instance reached out or attempted to reach out to the service registry
          #if any of the following error notifications occurred or if the policy itself was requested successfully
          @iut.has_audit_entry_with_message_and_flow_id?('Could not find policy',@test_id) ||
          @iut.has_audit_entry_with_message_and_flow_id?('No policy associated with service',@test_id) ||
          @iut.has_audit_entry_with_message_and_flow_id?('Could not retrieve policy for service',@test_id) ||
          query_last_flow_identifier_from_policy == @test_id
        }
      end

      private

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

      def create_failure_in_service_registry_client
        parameters = { :operation => 'create-failure-in-service-registry-client' }
        @iut.query_endpoint(resource: 'service-registry-client-command-and-control',parameters: parameters)
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
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Finding service URIs",                                                           ServiceComponent::Test::SoarScServiceRegistryOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Authorization policies",                                                         ServiceComponent::Test::SoarScServiceRegistryOrchestrationProvider)
