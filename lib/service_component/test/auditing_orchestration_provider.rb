module ServiceComponent
  module Test
    class SoarScAuditingOrchestrationProvider < BaseOrchestrationProvider
      def given_audit_message(message)
        @audit_event_message = message
      end

      def given_auditing_level(level)
        @audit_level = level
      end

      def given_flow_identifier
        @test_flow_id ="#{SecureRandom.hex(14)}#{Time.now.to_i.to_s(16)}#{SecureRandom.hex(14)}"
      end

      def given_valid_time
        @test_timestamp = Time.new(2016,1,1,15,25,12, "+09:00")
      end

      def given_invalid_time
        @test_timestamp = "Not valid time string"
      end


      def notify_audit
        #Default the audit level and flow identifiers if not given explicitly
        @audit_level = :debug if @audit_level.nil?
        @test_flow_id="#{SecureRandom.hex(14)}#{Time.now.to_i.to_s(16)}#{SecureRandom.hex(14)}" if @test_flow_id.nil?


        send_to_test_audit_endpoint(@audit_level, @test_flow_id, @audit_event_message, @test_timestamp)
        @latest_audit_event_entry = @iut.get_last_audit_entry

        #puts @test_flow_id
        #puts @latest_audit_event_entry
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

      def has_notified_with_timestamp?
        @test_timestamp.utc.iso8601(3) == extract_timestamp_from_audit_entry(@latest_audit_event_entry)
      end

      def has_notified_with_utc_timestamp?
        @test_timestamp.utc.iso8601(3) == extract_timestamp_from_audit_entry(@latest_audit_event_entry)
      end

      def is_correctly_formatted?
        not /(debug|info|warn|error|fatal),[^,]*,[^,]*,[^,]*,.*/.match(@latest_audit_event_entry).nil?
      end

      private

      def send_to_test_audit_endpoint(level, flow_id, data, timestamp)
        require 'uri'
        uri = URI.parse("#{@iut.uri}/audit-test/notify-event")
        params = { :operation => 'notify', :level => level, :flow_identifier => flow_id, :timestamp => timestamp, :data => data.to_s }
        uri.query = URI.encode_www_form( params )
        require 'net/http'
        Net::HTTP.get(uri)
      end

      def extract_level_from_audit_entry(audit_entry)
        audit_entry.split(',')[0]
      end

      def extract_service_identifier_from_audit_entry(audit_entry)
        audit_entry.split(',')[1]
      end

      def extract_flow_identifier_from_audit_entry(audit_entry)
        audit_entry.split(',')[2]
      end

      def extract_timestamp_from_audit_entry(audit_entry)
        audit_entry.split(',')[3]
      end

      def extract_message_from_audit_entry(audit_entry)
        audit_entry.split(',')[4]
      end
    end
  end
end

ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Auditing service component actions", ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
ServiceComponent::Test::OrchestrationProviderRegistry.instance.register("tfa", "Pluggable auditing provider", ServiceComponent::Test::SoarScAuditingOrchestrationProvider)
