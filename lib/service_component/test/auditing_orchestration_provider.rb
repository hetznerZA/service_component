

module ServiceComponent
  module Test
    class SoarScAuditingOrchestrationProvider < BaseOrchestrationProvider
      ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS = 1 unless defined? ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS;   ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS.freeze

      def given_audit_message(message)
        @audit_event_message = message
      end

      def given_auditing_level(level)
        @audit_level = level
      end

      def given_flow_identifier
        @test_flow_id ="#{SecureRandom.hex(14)}#{Time.now.to_i.to_s(16)}#{SecureRandom.hex(14)}"
      end

      def notify_audit
        #TODO add the givens and not have it here
        #@test_flow_id="#{SecureRandom.hex(14)}#{Time.now.to_i.to_s(16)}#{SecureRandom.hex(14)}" if @test_flow_id.nil?



        @previous_audit_event_entry = @iut.get_last_audit_entry
        notify_event(@audit_level, @test_flow_id, @audit_event_message, @test_timestamp)
        @latest_audit_event_entry = @iut.get_last_audit_entry

        #puts @test_flow_id
        #puts @latest_audit_event_entry
      end


      def given_request_without_flow_identifier
        @previous_audit_event_entry = @iut.get_last_audit_entry
        notify_event(@audit_level, nil, @audit_event_message, @test_timestamp)
        @latest_audit_event_entry = @iut.get_last_audit_entry
        #puts @previous_audit_event_entry
        #puts @latest_audit_event_entry
      end

      def given_request_with_flow_identifier

      end

      def forward_request_with_flow_identifier

      end



      def has_been_notified?
        @test_flow_id == extract_flow_identifier_from_audit_entry(@latest_audit_event_entry)
      end

      def has_audited_with_level?(level)
        level.to_s == extract_level_from_audit_entry(@latest_audit_event_entry)
      end

      def has_notified_with_message?(message)
        message == @audit_event_message
      end

      def has_notified_with_my_identifier?
        @iut.environment["IDENTIFIER"] == extract_service_identifier_from_audit_entry(@latest_audit_event_entry)
      end

      def has_notified_with_flow_identifier?
        @test_flow_id == extract_flow_identifier_from_audit_entry(@latest_audit_event_entry)
      end

      def has_notified_with_new_flow_identifier?
        extract_flow_identifier_from_audit_entry(@previous_audit_event_entry) != extract_flow_identifier_from_audit_entry(@latest_audit_event_entry)
      end

      def has_notified_with_timestamp?
        ALLOWED_TIMESTAMP_DEVIATION_IN_SECONDS > (Time.now - Time.parse(extract_timestamp_from_audit_entry(@latest_audit_event_entry))).abs
      end

      def has_notified_with_utc_timestamp?
        Time.parse(extract_timestamp_from_audit_entry(@latest_audit_event_entry)).utc?
      end

      def is_correctly_formatted?
        not /(debug|info|warn|error|fatal),[^,]*,[^,]*,[^,]*,.*/.match(@latest_audit_event_entry).nil?
      end

      private

      def notify_event(level, flow_id, data, timestamp)
        parameters = { :operation => 'notify', :level => level, :flow_identifier => flow_id, :timestamp => timestamp, :data => data.to_s }
        query_endpoint('audit-test/notify',parameters)
      end

      def pause_audit_buffer
        parameters = { :operation => 'pause' }
        query_endpoint('audit-test/buffer',parameters)
      end

      def continue_audit_buffer
        parameters = { :operation => 'continue' }
        query_endpoint('audit-test/buffer',parameters)
      end

      def view_audit_buffer
        parameters = { :operation => 'view' }
        query_endpoint('audit-test/buffer',parameters)
      end

      def kick_off_flow_test(correlation_identifier)
        parameters = { :operation => 'flow-test-action-1', :correlation_identifier => correlation_identifier }
        query_endpoint('audit-test/flow',parameters)
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
        audit_entry.split(',')[4] unless audit_entry.nil?
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Auditing service component actions", ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable auditing provider", ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
