require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class ExecutionEnvironmentOrchestrationProvider < SoarScBootstrapOrchestrationProvider

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

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Supporting development environment for applications", ServiceComponent::Test::ExecutionEnvironmentOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Supporting production environment for applications",  ServiceComponent::Test::ExecutionEnvironmentOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Supporting staging environment for applications",     ServiceComponent::Test::ExecutionEnvironmentOrchestrationProvider)
