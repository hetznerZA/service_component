module ServiceComponent
  module Test
    class SoarScBootstrapOrchestrationProvider < BootstrapOrchestrationProvider
      def given_environment_configuration
        @environment = 
          { 'RACK_ENV' => 'production',
            'CAS_SERVER' => 'https://login.konsoleh.co.za/cas',
            'IDENTIFIER' => 'iut.dev.auto-h.net',
            'SERVICE_REGISTRY' => 'http://service-registry.auto-h.net:8080',
            'CFGSRV_PROVIDER_ADDRESS' => 'https://vault.auto-h.net',
            #CFGSRV_IDENTIFIER: 'service-identifier.dev.auto-h.net'
            'CFGSRV_TOKEN' => 'TOKEN',
            'CFGSRV_PROVIDER' => 'vault',
            'SESSION_KEY' => 'uniquesessionkeyforsoarsc',
            'SESSION_SECRET' => 'replacethiswithasessionsecretthatisstrongandsharedamongstallinstancesofthisapplication'
          }
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