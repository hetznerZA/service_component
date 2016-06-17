module ServiceComponent
  module Test
    class SoarScBootstrapOrchestrationProvider < BootstrapOrchestrationProvider
      def given_environment_configuration
        # default valid environment provided from the environment.yml file and loaded implicitly
      end

      def has_received_notification?(message)
        return true if super(message)
        @iut.has_sent_notification?(message)
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with a service identifier", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("production", "Bootstrapping with a service identifier", ServiceComponent::Test::SoarScBootstrapOrchestrationProvider)
