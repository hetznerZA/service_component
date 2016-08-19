require 'persistent-cache'
require 'soar_pl/authorization_policy'

module SoarSc
  module Authorization
    class AuthorizationPolicyRejectAll < ::SoarPl::AuthorizationPolicy
      def initialize
        super('authorization-policy-reject-all', {})
      end

      private

      def apply_rule_set(subject_identifier, requestor_identifier, resource_identifier, request, subject_roles, attributes)
        $stderr.puts "subject_identifier #{subject_identifier} requestor_identifier #{requestor_identifier} resource_identifier #{resource_identifier} request #{request} subject_roles #{subject_roles} attributes #{attributes}"
        false
      end
    end
  end
end


module SoarSc
  module Web
    module Models
      class PolicyRejectAllModel < ConfiguredModel
        attr_accessor :configuration
        attr_accessor :dependencies

        def initialize(configuration)
          super(configuration)
          self.initialize
        end

        def self.initialize
          @cache = Persistent::Cache.new('test-information', nil, Persistent::Cache::STORAGE_RAM)
          @cache['last_flow_identifier'] = 'no-flow-identifier-yet'
        end

        def self.last_flow_identifier
          self.initialize if @cache.nil?
          @cache['last_flow_identifier']
        end

        def self.last_flow_identifier=(last_flow_identifier)
          self.initialize if @cache.nil?
          @cache['last_flow_identifier'] = last_flow_identifier
        end
      end
    end
  end
end
