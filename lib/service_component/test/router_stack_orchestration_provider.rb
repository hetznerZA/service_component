require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class RouterStackOrchestrationProvider < SoarScBootstrapOrchestrationProvider

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

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Verifying signed requests",       ServiceComponent::Test::RouterStackOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Routing stack",                   ServiceComponent::Test::RouterStackOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Routing requests to controllers", ServiceComponent::Test::RouterStackOrchestrationProvider)
