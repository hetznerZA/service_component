require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class AuthenticationAndAuthorizationOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
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
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Authorization policies",                         ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
