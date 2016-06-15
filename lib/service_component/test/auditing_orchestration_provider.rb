require "./lib/service_component/test/bootstrap_orchestration_provider"
require "./lib/service_component/test/soar_sc_bootstrap_orchestration_provider"


module ServiceComponent
  module Test
    class SoarScAuditingOrchestrationProvider < SoarScBootstrapOrchestrationProvider
      ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS = 1 unless defined? ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS; ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS.freeze
      BUFFER_FILL_MESSAGE = "BufferFiller"       unless defined? BUFFER_FILL_MESSAGE;                    BUFFER_FILL_MESSAGE.freeze

      # Given / Test setup methods

      def setup
        given_environment_configuration
        super
        select_auditor
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
        deselect_auditor
        fill_audit_buffer
      end

      def given_the_audit_buffer_is_empty
        select_auditor #selecting an auditor will ensure the buffer is empty since it will immediately process all elements
        sleep(1) #sleep ensures that the buffer is emptied before the test is run
      end

      def given_the_audit_buffer_contains_events
        deselect_auditor #deselecting an auditor will ensure the buffer can be filled since no messages will be processed
        @test_flow_id = create_unique_id
        notify_event(DEBUG_LEVEL, @test_flow_id, BUFFER_FILL_MESSAGE)
      end

      def given_valid_auditing_provider
        @iut.configuration['auditing']['provider'] = 'SoarScAuditingProvider'
      end

      def given_invalid_auditing_provider
        @iut.configuration['auditing']['provider'] = 'UnknownAuditingProvider'
      end

      def given_auditing_provider_initialization_failure
        # specify an incorrect auditing level which will result in an auditing provider
        # initialization failure
        @iut.configuration['auditing']['level'] = 'wrong'
      end

      def given_valid_auditing_provider_configuration
        # by default there will be a valid auditing provider configuration
      end

      def given_invalid_auditing_provider_configuration
        # specify an incorrect auditing level which will result in an auditing provider
        # configuration failure
        @iut.configuration['auditing']['level'] = 'wrong'
      end

      def given_no_auditing_provider_configuration
        @iut.configuration['auditing'] = nil
      end

      def given_valid_auditor
        # by default there will be a valid auditor
      end

      def given_invalid_auditor
        # remove all the auditors which will prevent the auditing provider from
        # creating a valid auditor
        @iut.configuration['auditing']['auditors'] = nil
      end

      def given_auditor_initialization_failure
        # specify an incorrect auditing level which will result in an auditor
        # initialization failure
        @iut.configuration['auditing']['level'] = 'wrong'
      end



      # When / Test action methods

      def notify_audit
        @previous_audit_event_entry = @iut.get_latest_audit_entries
        notify_event(@audit_level, @test_flow_id, @audit_event_message)
        sleep(0.5)
      end

      def receive_a_request
        @previous_audit_event_entry = @iut.get_latest_audit_entries
        @correlation_identifier = create_unique_id
        start_flow_test_chain(@correlation_identifier,@test_flow_id)
        sleep(0.5)
      end

      def forward_request_to_another_service
        @correlation_identifier = create_unique_id
        start_flow_test_chain(@correlation_identifier,@test_flow_id)
        sleep(0.5)
      end

      def can_report_to_auditor
        @previous_audit_event_entry = @iut.get_latest_audit_entries
        select_auditor
        sleep(2)
      end

      def cannot_report_to_auditor
        @previous_audit_event_entry = @iut.get_latest_audit_entries
        deselect_auditor
        sleep(0)
      end

      #Then / Test check methods

      def has_been_notified?
        @test_flow_id == extract_flow_identifier_from_audit_entry(@iut.get_latest_audit_entries)
      end

      def has_audited_with_level?(level)
        level.to_s == extract_level_from_audit_entry(@iut.get_latest_audit_entries)
      end

      def has_notified_with_message?(message)
        message == extract_message_from_audit_entry(@iut.get_latest_audit_entries)
      end

      def has_notified_with_my_identifier?
        @iut.environment["IDENTIFIER"] == extract_service_identifier_from_audit_entry(@iut.get_latest_audit_entries)
      end

      def has_notified_with_flow_identifier?
        @test_flow_id == extract_flow_identifier_from_audit_entry(@iut.get_latest_audit_entries)
      end

      def has_notified_with_new_flow_identifier?
        extract_flow_identifier_from_audit_entry(@previous_audit_event_entry) != extract_flow_identifier_from_audit_entry(@iut.get_latest_audit_entries)
      end

      def has_notified_with_flow_identifier_in_new_request?
        (@test_flow_id == extract_flow_identifier_from_audit_entry(@iut.get_latest_audit_entries)) and
        (extract_message_from_audit_entry(@iut.get_latest_audit_entries).include?('flow-test-action-2')) and
        (extract_message_from_audit_entry(@iut.get_latest_audit_entries).include?(@correlation_identifier))
      end

      def has_notified_with_timestamp?
        ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS > (Time.now - Time.parse(extract_timestamp_from_audit_entry(@iut.get_latest_audit_entries))).abs
      end

      def has_notified_with_utc_timestamp?
        Time.parse(extract_timestamp_from_audit_entry(@iut.get_latest_audit_entries)).utc?
      end

      def is_correctly_formatted_as?(regular_expression)
        not regular_expression.match(@iut.get_latest_audit_entries).nil?
      end

      def has_removed_the_oldest_event_from_the_buffer?
        select_auditor
        sleep(2)
        not @iut.get_latest_audit_entries(get_iut_buffer_size).include?("#{BUFFER_FILL_MESSAGE} 1\n")
      end

      def did_report_anything?
        sleep(1) #Sleep a bit to make sure a delay did not create a false positive
        @previous_audit_event_entry != @iut.get_latest_audit_entries
      end

      def reported_oldest_event_in_buffer?
        @test_flow_id == extract_flow_identifier_from_audit_entry(@iut.get_latest_audit_entries)
      end

      def have_initialized_auditing_provider?
        notify_event(DEBUG_LEVEL, @test_flow_id, BUFFER_FILL_MESSAGE)
        did_report_anything?
      end

      def have_initialized_auditor?
        notify_event(DEBUG_LEVEL, @test_flow_id, BUFFER_FILL_MESSAGE)
        did_report_anything?
      end

      private

      def fill_audit_buffer
        for i in 1..get_iut_buffer_size do
          notify_event(@audit_level, @test_flow_id, "#{BUFFER_FILL_MESSAGE} #{i}")
        end
      end

      def notify_event(level, flow_id, data)
        parameters = { :operation => 'notify', :level => level, :flow_identifier => flow_id, :data => data.to_s }
        query_endpoint('audit-test/notify',parameters)
      end

      def start_flow_test_chain(correlation_identifier, flow_identifier)
        parameters = { :operation => 'flow-test-action-1', :flow_identifier => flow_identifier, :correlation_identifier => correlation_identifier }
        query_endpoint('audit-test/flow',parameters)
      end

      def select_auditor
        parameters = { :operation => 'select' }
        query_endpoint('audit-test/auditor',parameters)
      end

      def deselect_auditor
        parameters = { :operation => 'deselect' }
        query_endpoint('audit-test/auditor',parameters)
      end

      def query_endpoint(resource,parameters)
        require 'uri'
        uri = URI.parse("#{@iut.uri}/#{resource}")
        uri.query = URI.encode_www_form( parameters )
        require 'net/http'
        Net::HTTP.get(uri)
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
        "#{SecureRandom.hex(14)}#{Time.now.to_i.to_s(16)}#{SecureRandom.hex(14)}"
      end

      def get_iut_buffer_size
        @iut.configuration['auditing']['queue_size'].to_i
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Auditing service component actions", ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable auditing providers",       ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable auditors",                 ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with auditing provider configuration including auditing level", ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Bootstrapping with auditor configuration",                                    ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
