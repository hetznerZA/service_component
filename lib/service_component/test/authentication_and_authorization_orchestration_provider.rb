require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class AuthenticationAndAuthorizationOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
        @iut.set_execution_environment('production')
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

      def given_an_development_execution_environment
        @iut.set_execution_environment('development')
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

      def have_an_initialized_authentication_provider?
        #for test purposes we use basic auth so check that it is initialized
        @iut.audit_entry_with_message_exist?('BASIC_AUTH_USER specified, using basic auth for authentication. Basic auth is not recommended for production')
      end

      private

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
