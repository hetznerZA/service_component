require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class SessionOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
      end

      def given_a_session_client
        #TODO
      end

      def given_sessions_use_is_undefined
        @iut.environment['USE_SESSIONS'] = nil
      end

      def given_sessions_use_is_invalid
        @iut.environment['USE_SESSIONS'] = 'notrueorfalse'
      end

      def given_sessions_are_not_used
        @iut.environment['USE_SESSIONS'] = 'false'
      end

      def given_sessions_are_used
        @iut.environment['USE_SESSIONS'] = 'true'
      end

      def given_no_session_key_is_present
        @iut.environment['SESSION_KEY'] = nil
      end

      def given_no_session_secret_is_present
        @iut.environment['SESSION_SECRET'] = nil
      end

      def given_session_key_is_invalid
        @iut.environment['SESSION_KEY'] = ';'
      end

      def given_session_secret_is_invalid
        @iut.environment['SESSION_SECRET'] = 'too_short'
      end

      def given_a_session_secret
        #create 32 byte secret string
        @iut.environment['SESSION_SECRET'] = "#{SecureRandom.hex(14)}"
      end

      def given_a_unique_session_key
        @iut.environment['SESSION_KEY'] = 'a_unique_session_key_for_testing'
      end

      def receive_a_request
        #bootstrap the service component to ensure the environment for the test has been incorporated.
        bootstrap

        false
      end

      def this_service_component_must_not_be_less_compliant_than_rack?
        false
      end

      def a_session_is_not_used_when_servicing_the_request?
        false
      end

      def the_session_is_encrypted_using_the_secret?
        false
      end

      def session_interactions_are_persisted_using_the_key?
        false
      end


      private

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Session support", ServiceComponent::Test::SessionOrchestrationProvider)
