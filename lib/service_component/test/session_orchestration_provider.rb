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
      end

      def given_a_session_client
        #implicitly provided by the iut
      end

      def given_a_session
        #implicitly provided by the iut
      end

      def receive_a_request
        bootstrap #bootstrap the service component to ensure the environment for the test has been incorporated.
        @response_to_request = @iut.query_endpoint('architectural-test-service-with-registered-existing-policy')
      end

      def this_service_component_must_not_be_less_compliant_than_rack?
        # byebug
        cookie_data = decode_set_cookie(@response_to_request['Set-Cookie'])
        cookie_data['rfc6265_provider'] == 'Rack::Session::Abstract::SessionHash'
      end

      def a_session_is_not_used_when_servicing_the_request?
        @response_to_request['Set-Cookie'].nil?
      end

      def the_session_integrity_is_verified?
        false
        #byebug

        # crypt = ActiveSupport::MessageEncryptor.new(@iut.environment['SESSION_SECRET'])                       # => #<ActiveSupport::MessageEncryptor ...>
        # encrypted_data = crypt.encrypt_and_sign('my secret data')              # => "NlFBTTMwOUV5UlA1QlNEN2xkY2d6eThYWWh..."
        # crypt.decrypt_and_verify(encrypted_data)                               # => "my secret data"
        #
        # cookie = @response_to_request['Set-Cookie']
        # unescaped_cookie_value = cookie.split('--').first.split('=')[1]
        # escaped_cookie_value = CGI.escape(unescaped_cookie_value).gsub("%0A", "")
        # cookie_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, @iut.environment['SESSION_SECRET'], escaped_cookie_value.gsub("%3D", "="))
        #
        #
        #
        # verifier = ActiveSupport::MessageVerifier.new(@iut.environment['SESSION_SECRET'], 'SHA1')
        # verifier.verify(session)
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

    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Session support", ServiceComponent::Test::SessionOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with session configuration", ServiceComponent::Test::SessionOrchestrationProvider)
