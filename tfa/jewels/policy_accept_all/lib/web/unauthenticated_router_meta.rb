
        add_unsigned_unauthorized_route('/authorization-policy-accept-all/get_latest_flow_identifier',
          "Test service that provides the last flow_identifier that was processed by authorization-policy-accept-all") do |request|
          http_code, body = SoarSc::Web::Controllers::PolicyAcceptAllController.new(@configuration).get_latest_flow_identifier(request)
          SoarSc::Web::Views::JSON.render(http_code, body)
        end

        add_unsigned_unauthorized_route('/authorization-policy-accept-all',
          "Test service that provides a simple policy endpoint accepting any subject_identifier") do |request|
          http_code, body = SoarSc::Web::Controllers::PolicyAcceptAllController.new(@configuration).serve(request)
          SoarSc::Web::Views::JSON.render(http_code, body)
        end
