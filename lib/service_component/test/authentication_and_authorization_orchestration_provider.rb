require 'json'
require 'yaml'
require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"
require 'rack'
require 'net/http'
require 'smaak'

require 'smaak/associate'
require 'smaak/server'
require 'smaak/client'
require 'smaak/auth_message'
require 'smaak/smaak_service'

module ServiceComponent
  module Test
    class AuthenticationAndAuthorizationOrchestrationProvider < SoarScBootstrapOrchestrationProvider

      def setup
        super
        @iut.set_execution_environment('production')
        given_an_authenticated_human_identity
        given_no_authorization_policy
        create_smaak_client
      end

      def given_a_request_for_a_service
        #request is setup as a collection of other aspects right before the request.
        @test_id = create_unique_id
      end

      def given_an_authenticated_identity
        given_an_authenticated_human_identity
      end

      def given_a_request_that_requires_authentication
        @service_endpoint_name = 'architectural-test-service-access-point-1'
      end

      def given_an_authenticated_human_identity
        @user = 'dev'
        @password = 'dev'
        @identity_type = 'human'
      end

      def given_an_authenticated_service_identity
        @identity_type = 'service'
      end

      def given_no_authenticated_identity
        @user = nil
        @password = nil
      end

      def given_a_request_that_does_not_require_authentication
        @service_endpoint_with_no_authentication = true
      end

      def given_an_authentication_failure
        @iut.environment['CAS_SERVER'] = 'https://invalid-login.konsoleh.co.za/cas'
        @iut.set_execution_environment('production')
      end

      def given_an_originator_of_authentication_delegation
        #This is implemented using the standard testing human identity "dev"
        given_an_authenticated_human_identity
      end

      def given_a_delegated_request
        @service_name = 'architectural-test-service_that_will_result_in_delegation'
      end

      def given_a_request_requiring_authentication
        @service_endpoint_name = 'architectural-test-service-access-point-1'
      end

      def given_an_authenticaton_provider_initialization_failure
        given_an_invalid_authentication_provider
      end

      def given_a_valid_authentication_provider
        #override the inherited method that will setup CAS as the provider so that
        #basic auth will be used implicitly.
      end

      def given_a_valid_authorization_provider
        #by default there is always a valid authorization provider
      end

      def given_an_authorization_policy_that_approves
        @using_policy = '-using-always-allow-authorization-policy'
      end

      def given_an_authorization_policy_that_does_not_approve
        @using_policy = '-using-always-deny-authorization-policy'
      end

      def given_no_authorization_policy
        @using_policy = '-using-no-authorization-policy'
      end

      def given_an_authorization_policy
        #default to this policy, but specialized using other givens
        @using_policy = '-using-always-allow-authorization-policy'
      end

      def given_an_authorization_failure
        @using_policy = '-using-invalid-authorization-policy'
      end

      def given_an_authorization_provider_initialization_failure
        @iut.given_an_authorization_provider_initialization_failure
      end

      def authorize_the_service
        @service_name = "authorization-tests/architectural-test-service#{@using_policy}"
        authorize
      end

      def when_asked_whether_the_request_has_authenticated
        @service_name = "authorization-tests/architectural-test-service#{@using_policy}"
        authorize
      end

      def when_asked_who_has_authenticated
        if 'service' == @identity_type
          @service_name = 'architectural-test-service-using-smaak'
        elsif @service_endpoint_with_no_authentication
          @service_name = 'endpoint-not-requiring-authentication'
        else
          @service_name = "authorization-tests/architectural-test-service#{@using_policy}"
        end
        authorize
      end

      def when_asked_who_delegated_the_authentication
        authorize
      end

      def when_asked_whether_the_request_has_been_delegated
        @service_name = "authorization-tests/architectural-test-service#{@using_policy}"
        authorize
      end

      def authorize
        if 'service' == @identity_type
          @iut.environment.delete('CAS_SERVER')
          @iut.environment.delete('BASIC_AUTH_USER')
        end
        bootstrap
        if 'service' == @identity_type
          @result = @smaak_client.get('service-server.dev.auto-h.net',
                                       "http://localhost:9393/#{@service_name}/",
                                       { 'request' => {'bla' => 'foo'},
                                         'identifier' => "service-client.dev.auto-h.net"}.to_json)
        else
          @result = @iut.query_endpoint(user: @user, password: @password, resource: @service_name, parameters: { :flow_identifier => @test_id })
        end
      end

      def have_responded_with_true?
        '200' == @result.code
      end

      def have_responded_with_false?
        '401' == @result.code or
        '302' == @result.code  #redirect to cas for login
      end

      def have_responded_with_the_authenticated_human_identity_identifier?
        'dev' == JSON.parse(@result.body)['authentication_identity']
      end

      def have_responded_with_the_authenticated_service_identity_identifier?
        'service-client.dev.auto-h.net' == JSON.parse(@result.body)['authentication_identity']
      end

      def have_responded_with_nil?
        JSON.parse(@result.body)['authentication_identity'].nil?
      end

      def have_responded_with_no_authenticated_identity?
        @iut.have_responded_with_no_authenticated_identity?
      end

      def have_responded_with_the_authenticated_identity_identifier_in_request_not_requiring_authentication?
        @iut.have_responded_with_the_authenticated_identity_identifier_in_request_not_requiring_authentication?
      end

      def have_notified_of_a_failure_determining_authentication_identity?
        @iut.have_notified_of_a_failure_determining_authentication_identity?
      end

      def have_responded_with_with_the_authenticated_identity_identifier?
        'dev' == JSON.parse(@result.body)['authentication_identity']
      end

      def have_responded_with_developer?
        'developer' == JSON.parse(@result.body)['authentication_identity']
      end

      def have_not_applied_the_policy?
        not have_applied_the_policy?
      end

      def have_applied_the_policy?
        @iut.has_audit_entry_with_message_and_flow_id?('PolicyAcceptAllController serving',@test_id) or
        @iut.has_audit_entry_with_message_and_flow_id?('PolicyRejectAllController serving',@test_id)
      end

      def have_responded_with_allow?
        '200' == @result.code
      end

      def have_responded_with_deny?
        '403' == @result.code or
        '401' == @result.code
      end

      def have_notified_authorization_failure?
        #there are many messages to this affect but they all result in the authorization being rejected
        @iut.has_audit_entry_with_message_and_flow_id?('Policy rejected authorization request',@test_id)
      end

      def have_an_initialized_authentication_provider?
        #for test purposes we use basic auth so check that it is initialized
        @iut.audit_entry_with_message_exist?('BASIC_AUTH_USER specified, using basic auth for authentication. Basic auth is not recommended for production')
      end

      def have_responded_with_nil_due_to_failure_to_determine_authentication_identity?
        @iut.have_responded_with_nil_due_to_failure_to_determine_authentication_identity?
      end

      def have_an_initialized_authorization_provider?
        JSON.parse(get_authorization_provider_info.body)['access_manager'].include?("Soar::Authorization::AccessManager")
      end

      private

      def create_smaak_client
        @smaak_client = Smaak::Client.new
        @smaak_client.set_identifier('service-client.dev.auto-h.net')
        @smaak_client.set_private_key(get_smaak_client_private_key)
        @smaak_client.add_association('service-server.dev.auto-h.net', get_smaak_server_public_key, get_client_pre_shared_key, false) # false = not encrypted
      end

      def get_smaak_client_private_key
        configuration = YAML.load_file("#{ENV['SOAR_DIR']}/smaak/client.yml")
        configuration['private_key']
      end

      def get_smaak_server_public_key
        configuration = YAML.load_file("#{ENV['SOAR_DIR']}/smaak/server.yml")
        configuration['public_key']
      end

      def get_client_pre_shared_key
        @iut.smaak_client_psk
      end

      def get_authorization_provider_info
        @test_flow_id = create_unique_id
        parameters = { :flow_identifier => @test_flow_id }
        @iut.query_endpoint(resource: 'authorization-tests/query-initialization-provider', parameters: parameters)
      end

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Allowing authenticated access",                  ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Identifying authenticated identities",           ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Allowing delegation of authentication",          ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Disallowing unauthenticated access",             ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Supporting development workflow authentication", ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable authentication provider",              ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Supporting development workflow authorization",  ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable authorization provider",               ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Authorization policies",                         ServiceComponent::Test::AuthenticationAndAuthorizationOrchestrationProvider)
