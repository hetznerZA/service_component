require 'json'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"
require 'active_support'
require 'rack'

module ServiceComponent
  module Test
    class SessionOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
        given_sessions_are_used
        given_a_session_client
        given_a_valid_session_key
      end

      def given_a_session_client
        #implicitly provided by the iut
      end

      def given_a_session
        #make sure we are bootstrapped and hit an endpoint to get a cookie so that we can use it later as a valid session
        bootstrap
        @session_cookie = @iut.query_endpoint(resource: 'architectural-test-service-with-registered-existing-policy')['Set-Cookie']
        @cookie_test_message = decode_set_cookie(@session_cookie)['test_message']
      end

      def given_a_invalid_session
        #make sure we are bootstrapped and hit an endpoint to get a cookie, make a modification and save it so that we can use it later as an invalid session
        given_a_session
        zero_cookie_signature
      end

      def receive_a_request
        bootstrap #bootstrap the service component to ensure the environment for the test has been incorporated.
        @response_to_request = @iut.query_endpoint(resource: 'architectural-test-service-with-registered-existing-policy', cookie: @session_cookie)
      end

      def this_service_component_must_not_be_less_compliant_than_rack?
        cookie_data = decode_set_cookie(@response_to_request['Set-Cookie'])
        cookie_data['rfc6265_provider'] == 'Rack::Session::Abstract::SessionHash'
      end

      def a_session_is_not_used_when_servicing_the_request?
        @response_to_request['Set-Cookie'].nil?
      end

      def service_component_enables_verification_of_the_session_integrity?
        #check that there is a 40 character signature as expected
        retrieve_signature_from_set_cookie(@response_to_request['Set-Cookie']).length == 40
      end

      def the_session_integrity_is_verified?
        JSON.parse(@response_to_request.body)['returned_session_test_message'] == @cookie_test_message
      end

      def session_interactions_are_persisted_using_the_key?
        @response_to_request['Set-Cookie'].include?('a_unique_session_key_for_testing')
      end

      private

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

      def decode_set_cookie(cookie)
        base64data = cookie.split('--').first.split('=')[1]
        Rack::Session::Cookie::Base64::Marshal.new.decode(URI.unescape(base64data))
      end

      def retrieve_signature_from_set_cookie(cookie)
        cookie.split('--').last.split("\;").first
      end

      def zero_cookie_signature
        cookie_portion_before_signature = @session_cookie.split('--').first
        cookie_portion_signature_plus_trail = @session_cookie.split('--').last
        cookie_portion_signature_plus_trail = cookie_portion_signature_plus_trail.sub(/^.{40}/, "#{SecureRandom.hex(20)}")
        @session_cookie = "#{cookie_portion_before_signature}--#{cookie_portion_signature_plus_trail}"
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Session support", ServiceComponent::Test::SessionOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with session configuration", ServiceComponent::Test::SessionOrchestrationProvider)
