module ServiceComponent
  module Test
    class BootstrapOrchestrationProvider < BaseOrchestrationProvider
      def bootstrap
        @iut.clear_messages
        @bootstrap_status = @iut.bootstrap
      end

      def has_completed_bootstrap?
        @bootstrap_status['status'] == 'success'
      end

      def has_not_completed_bootstrap?
        not has_completed_bootstrap?
      end

      def has_remembered_service_identifier?
        @iut.environment['IDENTIFIER'] == @bootstrap_status['data']['environment']['IDENTIFIER']
      end

      def has_not_remembered_service_identifier?
        not has_remembered_service_identifier
      end
    end
  end
end
