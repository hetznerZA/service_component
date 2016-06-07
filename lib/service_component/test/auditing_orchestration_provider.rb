module ServiceComponent
  module Test
    class SoarScAuditingOrchestrationProvider < BaseOrchestrationProvider
      def given_audit_message(message)
        @audit_event_message = message
      end

      def given_auditing_level(level)
        @audit_level = level
      end

      def notify_audit
        @test_flow_id="#{SecureRandom.hex(14)}#{Time.now.to_i.to_s(16)}#{SecureRandom.hex(14)}"
        send_to_test_audit_endpoint(@audit_level, @test_flow_id, @audit_event_message)
        @latest_audit_event_entry = @iut.get_last_audit_entry

        puts @test_flow_id
        puts @latest_audit_event_entry
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

      private

      def send_to_test_audit_endpoint(level, flow_id, data)
        require 'uri'
        uri = URI.parse("#{@iut.uri}/audit-test")
        params = { :level => level, :flow_identifier => flow_id, :data => data.to_s }
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
