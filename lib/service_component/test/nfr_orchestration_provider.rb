require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class NfrOrchestrationProvider < SoarScBootstrapOrchestrationProvider

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

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Performance NFRs when fulfilling the performance architectural viewpoint", ServiceComponent::Test::NfrOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Quality NFRs when fulfilling the quality architectural viewpoint",         ServiceComponent::Test::NfrOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Security NFRs when fulfilling the security architectural viewpoint",       ServiceComponent::Test::NfrOrchestrationProvider)
