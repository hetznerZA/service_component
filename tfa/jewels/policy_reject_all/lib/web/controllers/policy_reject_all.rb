module SoarSc
  module Web
    module Controllers
      class PolicyRejectAllController < ConfiguredController
        def serve(request)
          SoarSc::auditing.info("PolicyRejectAllController serving",request.params['flow_identifier'])
          subject_identifier = request.params['subject_identifier']
          policy = SoarSc::Authorization::AuthorizationPolicyRejectAll.new
          result = policy.authorize(subject_identifier)
          SoarSc::Web::Models::PolicyRejectAllModel.last_flow_identifier = request.params['flow_identifier']
          [200, result.to_json]
        end

        def get_latest_flow_identifier(request)
          result = { 'last_flow_identifier' => SoarSc::Web::Models::PolicyRejectAllModel.last_flow_identifier}
          [200, result.to_json]
        end
      end
    end
  end
end
