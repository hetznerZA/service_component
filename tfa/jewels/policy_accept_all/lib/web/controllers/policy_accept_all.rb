module SoarSc
  module Web
    module Controllers
      class PolicyAcceptAllController < ConfiguredController
        def serve(request)
          SoarSc::auditing.info("PolicyAcceptAllController serving",request.params['flow_identifier'])
          subject_identifier = request.params['subject_identifier']
          policy = SoarSc::Authorization::AuthorizationPolicyAcceptAll.new
          result = policy.authorize(subject_identifier)
          SoarSc::Web::Models::PolicyAcceptAllModel.last_flow_identifier = request.params['flow_identifier']
          [200, result.to_json]
        end

        def get_latest_flow_identifier(request)
          result = { 'last_flow_identifier' => SoarSc::Web::Models::PolicyAcceptAllModel.last_flow_identifier}
          [200, result.to_json]
        end
      end
    end
  end
end
