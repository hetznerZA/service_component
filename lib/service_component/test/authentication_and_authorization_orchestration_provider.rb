require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class AuthenticationAndAuthorizationOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
        @iut.set_execution_environment('production')
        bootstrap
      end

      def given_a_request_for_a_service
        #request is setup as a collection of other aspects right before the request.
        @test_id = create_unique_id
      end

      def given_an_authenticated_identity
        given_an_authenticated_human_identity
      end

      def given_a_request_that_requires_authentication
        @service_endpoint_name = 'architectural-test-service-access-point-1'
      end

      def given_an_authenticated_human_identity
        @user = 'dev'
        @password = 'dev'
      end

      def given_an_authenticated_service_identity
        puts "TODO not yet implementated using SMAAK"
      end

      def given_no_authenticated_identity
        @user = 'wrong username'
        @password = 'wrong password'
      end

      def given_a_request_that_does_not_require_authentication
        @service_endpoint_name = 'service_component/notify'
      end

      def given_an_authentication_failure
        @user = 'wrong username'
        @password = 'wrong password'
      end

      def given_an_originator_of_authentication_delegation
        puts "TODO not yet implementated"
      end

      def given_a_delegated_request
        puts "TODO not yet implementated"
      end

      def given_no_originator_of_authentication_delegation
        puts "TODO not yet implementated"
      end

      def given_a_request_requiring_authentication
        @service_endpoint_name = 'architectural-test-service-access-point-1'
      end

      def given_an_authenticaton_provider_initialization_failure
        given_an_invalid_authentication_provider
      end

      def given_a_valid_authentication_provider
        #override the inherited method that will setup CAS as the provider so that
        #basic auth will be used implicitly.
      end

      def given_a_valid_authorization_provider
        #by default there is always a valid authorization provider
      end

      def given_an_authorization_policy_that_approves
        @using_policy = '-using-always-allow-authorization-policy'
      end

      def given_an_authorization_policy_that_does_not_approve
        @using_policy = '-using-always-deny-authorization-policy'
      end

      def given_no_authorization_policy
        @using_policy = '-using-no-authorization-policy'
      end

      def given_an_authorization_policy
        #default to this policy, but specialized using other givens
        @using_policy = '-using-always-allow-authorization-policy'
      end

      def given_an_authorization_failure
        @using_policy = '-using-invalid-authorization-policy'
      end

      def given_an_authorization_provider_initialization_failure
        puts "Unable to test this at present in soar sc directly, simulate it indirectly by disabling the service registry on which authorization depends"
        @iut.environment['SERVICE_REGISTRY'] = 'not\a\uri'
      end

      def authorize_the_service
        @service_name = "authorization-tests/architectural-test-service#{@using_policy}"
        @service_name = "architectural-test-service-access-point-1"
        @authorization_result = @iut.query_endpoint(resource: @service_name, parameters: { :flow_identifier => @test_id })
      end

      def have_not_applied_the_policy?
        not have_applied_the_policy?
      end

      def have_applied_the_policy?
        true
        #TODO Need to look out for certain notifications or a success/failure
      end

      def have_responded_with_allow?
        '200' == @authorization_result.code
      end

      def have_responded_with_deny?
        #byebug
        '403' == @authorization_result.code
      end

      def have_an_initialized_authentication_provider?
        #for test purposes we use basic auth so check that it is initialized
        @iut.audit_entry_with_message_exist?('BASIC_AUTH_USER specified, using basic auth for authentication. Basic auth is not recommended for production')
      end

      def have_an_initialized_authorization_provider?
        JSON.parse(get_authorization_provider_info.body)['access_manager'].include?("SoarPolicyAccessManager::PolicyAccessManager")
      end

      private

      def get_authorization_provider_info
        @test_flow_id = create_unique_id
        parameters = { :flow_identifier => @test_flow_id }
        @iut.query_endpoint(resource: 'authorization-tests/query-initialization-provider', parameters: parameters)
      end

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Allowing authenticated access",                  ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Identifying authenticated identities",           ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Allowing delegation of authentication",          ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Disallowing unauthenticated access",             ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Supporting development workflow authentication", ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable authentication provider",              ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Supporting development workflow authorization",  ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable authorization provider",               ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Authorization policies",                         ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
