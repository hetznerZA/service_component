module ServiceComponent

  module Test

    module OrchestratorEnvironmentFactory
      class MissingEnvironmentVariable < StandardError; end
      class TestOrchestrationProviderNotSupported < StandardError; end

      def self.build(feature)
        identifier = ENV["TEST_ORCHESTRATION_PROVIDER"] or raise MissingEnvironmentVariable.new("missing environment variable: TEST_ORCHESTRATION_PROVIDER")
        registry = ServiceComponent::Test::OrchestrationProviderRegistry.instance
        provider = registry.lookup(identifier, feature) 
        p = provider.new
        p.inject_iut(ServiceComponent::Test::OrchestratorEnvironmentFactory::build_iut)
        p.setup
        p
      end

      def self.build_iut
        return ServiceComponent::Test::SoarScImplementation.new("http://localhost:9393") if ENV["TEST_ORCHESTRATION_PROVIDER"] == "tfa"
        return ServiceComponent::Test::SoarScImplementation.new("http://localhost:9393") if ENV["TEST_ORCHESTRATION_PROVIDER"] == "production"
        raise TestOrchestrationProviderNotSupported.new("Could not build iut for #{ENV["TEST_ORCHESTRATION_PROVIDER"]}")
      end
    end

  end

end
