require 'net/http'
require 'yaml'
require 'byebug'
require 'uri'
module ServiceComponent
  module Test
    class BaseOrchestrationProvider
      def setup
        @notifications = []
        setup_service_identifiers
      end

      def given_valid_service_identifier
        @iut.environment['IDENTIFIER'] = @valid_service_identifier
      end

      def given_invalid_service_identifier
        @iut.environment['IDENTIFIER'] = @invalid_service_identifier
      end

      def given_no_service_identifier
        @iut.environment['IDENTIFIER'] = @no_service_identifier
      end

      def inject_iut(iut)
        @iut = iut
      end

      def process_result(result)
        @result = result

        @notifications.push(@result['data']['notifications']) if @result and @result.is_a?(Hash) and @result['data'] and @result['data'].is_a?(Hash) and @result['data']['notifications']
        @notifications << @result if @result and not @result.is_a?(Hash)
        @notifications.flatten!
      end

      def success?
        (not @result.nil?) and (not @result['status'].nil?) and (@result['status'] == 'success')
      end

      def data
        @result['data']
      end

      def arrays_the_same?(a, b)
        c = a - b
        d = b - a
        (c.empty? and d.empty?)
      end

      def has_received_notification?(message)
        if @accept_failure_notifications_in_production
          @accept_failure_notifications_in_production = false
          return true
        end
        @notifications.each do |notification|
          #puts "COMPARING #{notification} with #{message}"
          return true if notification == message
        end
        false
      end

      private

      def setup_service_identifiers
        @valid_service_identifier = @iut.environment["IDENTIFIER"] #the environment file contains the valid service idenfier
        @invalid_service_identifier = ""
        @no_service_identifier = nil
      end
    end
  end
end
