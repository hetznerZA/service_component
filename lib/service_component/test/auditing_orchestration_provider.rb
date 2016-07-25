require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"

module ServiceComponent
  module Test
    class SoarScAuditingOrchestrationProvider < SoarScBootstrapOrchestrationProvider
      ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS = 2 unless defined? ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS; ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS.freeze
      BUFFER_FILL_MESSAGE = "BufferFiller"       unless defined? BUFFER_FILL_MESSAGE;                    BUFFER_FILL_MESSAGE.freeze

      # Given / Test setup methods

      def setup
        add_rejecting_auditor_configuration
        bootstrap
        super
        given_valid_service_identifier
        select_default_auditor
      end

      def given_audit_message(message)
        @audit_event_message = message
      end

      def given_request_message(message)
        @audit_event_message = message
      end

      def given_auditing_level(level)
        @audit_level = level
      end

      def given_flow_identifier
        @test_flow_id = create_unique_id
      end

      def given_request_with_flow_identifier
        @test_flow_id = create_unique_id
      end

      def given_request_without_flow_identifier
        @test_flow_id = nil
      end

      def given_the_audit_buffer_is_full
        select_rejecting_auditor
        fill_audit_buffer
      end

      def given_the_audit_buffer_is_empty
        select_default_auditor #selecting an auditor will ensure the buffer is empty since it will immediately process all elements
        sleep(1) #sleep ensures that the buffer is emptied before the test is run
      end

      def given_the_audit_buffer_contains_events
        select_rejecting_auditor #deselecting an auditor will ensure the buffer can be filled since no messages will be processed
        @test_flow_id = create_unique_id
        notify_event(DEBUG_LEVEL, @test_flow_id, BUFFER_FILL_MESSAGE)
      end

      def given_valid_auditing_provider
        @iut.configuration['auditing']['provider'] = 'SoarScAuditingProvider'
      end

      def given_invalid_auditing_provider
        @iut.configuration['auditing']['provider'] = 'UnknownAuditingProvider'
      end

      def given_invalid_auditing_provider_configuration
        @iut.configuration['auditing']['provider'] = 'UnknownAuditingProvider'
      end

      def given_auditing_provider_initialization_failure
        # specify an incorrect auditing level which will result in an auditing provider
        # initialization failure
        @iut.configuration = recurse_merge(@iut.configuration, {'auditing' => { 'level' => 'wrong'}})
      end

      def given_valid_auditing_provider_configuration
        @iut.configuration = recurse_merge(@iut.configuration, {'auditing' => { 'provider' => 'SoarScAuditingProvider'}})
      end

      def given_no_auditing_provider_configuration
        @iut.configuration['auditing'] = nil
      end

      def given_valid_configured_auditing_level
        @iut.configuration = recurse_merge(@iut.configuration, {'auditing' => { 'level' => 'debug'}})
      end

      def given_invalid_configured_auditing_level
        @iut.configuration = recurse_merge(@iut.configuration, {'auditing' => { 'level' => 'wrong'}})
      end

      def given_no_configured_auditing_level
        @iut.configuration = recurse_merge(@iut.configuration, {'auditing' => { 'level' => nil }})
      end

      def given_valid_auditor
        # by default there will be a valid auditor
      end

      def given_invalid_auditor
        @iut.configuration['auditing']['auditors'] = 'something that is not an auditor configuration'
      end

      def given_invalid_auditor_configuration
        @iut.configuration = recurse_merge(@iut.configuration, {'auditing' => { 'auditors' => { 'log4r' => { 'standard_stream' => 'stdwrong' }}}})
      end

      def given_no_auditor_configuation
        @iut.configuration = recurse_merge(@iut.configuration, {'auditing' => { 'auditors' => { 'log4r' => nil }}})
      end

      def given_auditor_initialization_failure
        # specify an incorrect auditing level which will result in an auditor
        # initialization failure
        @iut.configuration = recurse_merge(@iut.configuration, {'auditing' => { 'level' => 'wrong'}})
      end

      # When / Test action methods

      def notify_audit
        @previous_audit_event_entry = @iut.get_latest_test_orchestrator_audit_entry
        notify_event(@audit_level, @test_flow_id, @audit_event_message)
      end

      def receive_a_request
        @previous_audit_event_entry = @iut.get_latest_test_orchestrator_audit_entry
        @correlation_identifier = create_unique_id
        start_flow_test_chain(@correlation_identifier,@test_flow_id)
      end

      def forward_request_to_another_service
        @correlation_identifier = create_unique_id
        start_flow_test_chain(@correlation_identifier,@test_flow_id)
      end

      def can_report_to_auditor
        @previous_audit_event_entry = @iut.get_latest_test_orchestrator_audit_entry
        select_default_auditor
      end

      def cannot_report_to_auditor
        @previous_audit_event_entry = @iut.get_latest_test_orchestrator_audit_entry
        select_rejecting_auditor
      end

      #Then / Test check methods

      def has_been_notified?
        busy_wait(2,true) { @test_flow_id == extract_flow_identifier_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry) }
      end

      def has_not_been_notified?
        not has_been_notified?
      end

      def has_audited_with_level?(level)
        busy_wait(2,true) { level.to_s == extract_level_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry) }
      end

      def has_notified_with_message?(message)
        busy_wait(2,true) { "TEST_ORCHESTRATOR-#{message}" == extract_message_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry) }
      end

      def has_notified_with_my_identifier?
        busy_wait(2,true) { @iut.environment["IDENTIFIER"] == extract_service_identifier_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry) }
      end

      def has_notified_with_flow_identifier?
        busy_wait(2,true) { @test_flow_id == extract_flow_identifier_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry) }
      end

      def has_notified_with_new_flow_identifier?
        busy_wait(2,true) { extract_flow_identifier_from_audit_entry(@previous_audit_event_entry) != extract_flow_identifier_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry) }
      end

      def has_notified_with_flow_identifier_in_new_request?
        (@test_flow_id == extract_flow_identifier_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry)) and
        (extract_message_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry).include?('flow-test-action-2')) and
        (extract_message_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry).include?(@correlation_identifier))
      end

      def has_notified_with_timestamp?
        busy_wait(2,true) {
          timestamp_from_event = Time.parse(extract_timestamp_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry))
          ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS > (Time.now - timestamp_from_event).abs
        }
      end

      def has_notified_with_utc_timestamp?
        busy_wait(2,true) { Time.parse(extract_timestamp_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry)).utc? }
      end

      def is_correctly_formatted_as?(regular_expression)
        not regular_expression.match(@iut.get_latest_test_orchestrator_audit_entry).nil?
      end

      def has_removed_the_oldest_event_from_the_buffer?
        select_default_auditor
        reported_oldest_event = busy_wait(2,true) { @iut.get_latest_test_orchestrator_audit_entry(get_iut_buffer_size).include?("#{BUFFER_FILL_MESSAGE} 1\n") }
        not reported_oldest_event
      end

      def did_report_anything?
        busy_wait(2,true) { @previous_audit_event_entry != @iut.get_latest_test_orchestrator_audit_entry }
      end

      def did_not_report_anything?
        not did_report_anything?
      end

      def reported_oldest_event_in_buffer?
        busy_wait(2,true) { @test_flow_id == extract_flow_identifier_from_audit_entry(@iut.get_latest_test_orchestrator_audit_entry) }
      end

      def have_initialized_auditing_provider?
        notify_event(DEBUG_LEVEL, @test_flow_id, BUFFER_FILL_MESSAGE)
        did_report_anything?
      end

      def have_initialized_auditor?
        notify_event(DEBUG_LEVEL, @test_flow_id, BUFFER_FILL_MESSAGE)
        did_report_anything?
      end

      def has_remembered_auditing_provider_configuration?
        'SoarScAuditingProvider' == @bootstrap_status['data']['configuration']['auditing']['provider']
      end

      def has_remembered_auditing_level?
        @iut.configuration['auditing']['level'] == @bootstrap_status['data']['configuration']['auditing']['level']
      end

      def has_remembered_auditor_configuration?
        @iut.configuration['auditing']['auditors']['rejecting_test_auditor'] == @bootstrap_status['data']['configuration']['auditing']['auditors']['rejecting_test_auditor']
      end

      def has_received_notification_for_missing_auditor_configuration?
        #Untestable in SOAR_SC implementation due to the default auditor configuration
        #being supplied in the event that the configuration is not present.
        true
      end

      def has_received_notification_for_missing_auditing_configuration?
        #Untestable in SOAR_SC implementation due to the default auditor configuration
        #being supplied in the event that the configuration is not present.
        true
      end

      private

      def add_rejecting_auditor_configuration
        @iut.configuration['auditing'] = {} if not @iut.configuration['auditing']
        @iut.configuration['auditing']['auditors'] = {} if not @iut.configuration['auditing']['auditors']
        @iut.configuration['auditing']['auditors']['rejecting_test_auditor'] = {
          'adaptor' => 'ServiceComponent::RejectingTestAuditor',
          'nfrs' => {
            'accessibility' => 'rejecting',
            'privacy' => 'not encrypted',
            'reliability' => 'instance',
            'performance' => 'high'
          }
        }
      end

      def fill_audit_buffer
        # Need to create one more than the buffer size since the worker thread
        # will also be buffering an audit event it is trying send to the auditor
        events_to_create = get_iut_buffer_size + 1
        for i in 1..events_to_create do
          notify_event(@audit_level, create_unique_id, "#{BUFFER_FILL_MESSAGE} #{i}")
        end
      end

      def notify_event(level, flow_id, data)
        parameters = { :operation => 'notify', :level => level, :flow_identifier => flow_id, :data => "TEST_ORCHESTRATOR-#{data.to_s}" }
        query_endpoint('service_component/notify',parameters)
      end

      def start_flow_test_chain(correlation_identifier, flow_identifier)
        parameters = { :operation => 'flow-test-action-1', :flow_identifier => flow_identifier, :correlation_identifier => correlation_identifier, :data => "TEST_ORCHESTRATOR" }
        query_endpoint('service_component/flow',parameters)
      end

      def select_default_auditor
        parameters = { :operation => 'select_default_auditor' }
        query_endpoint('service_component/auditor',parameters)
      end

      def select_rejecting_auditor
        parameters = { :operation => 'select_rejecting_auditor' }
        query_endpoint('service_component/auditor',parameters)
      end

      def query_endpoint(resource,parameters)
        @iut.query_endpoint(resource: resource, parameters: parameters)
      end

      def extract_level_from_audit_entry(audit_entry)
        audit_entry.split(',')[0] unless audit_entry.nil?
      end

      def extract_service_identifier_from_audit_entry(audit_entry)
        audit_entry.split(',')[1] unless audit_entry.nil?
      end

      def extract_flow_identifier_from_audit_entry(audit_entry)
        audit_entry.split(',')[2] unless audit_entry.nil?
      end

      def extract_timestamp_from_audit_entry(audit_entry)
        audit_entry.split(',')[3] unless audit_entry.nil?
      end

      def extract_message_from_audit_entry(audit_entry)
        audit_entry.split(',')[4].delete!("\n") unless audit_entry.nil?
      end

      def create_unique_id
        "#{SecureRandom.hex(32)}"
      end

      def get_iut_buffer_size
        @bootstrap_status['data']['configuration']['auditing']['queue_worker']['queue_size'].to_i
      end

      def busy_wait(check_timeout, desired_result)
        BaseOrchestrationProvider::busy_wait(check_timeout, desired_result) { yield }
      end

      def recurse_merge(a,b)
        a.merge(b) do |_,x,y|
          if (x.is_a?(Hash) && y.is_a?(Hash)) then
            recurse_merge(x,y)
          else
            x
          end
        end
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Auditing service component actions", ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable auditing providers",       ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable auditors",                 ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with auditing provider configuration including auditing level", ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with auditor configuration",                                    ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
