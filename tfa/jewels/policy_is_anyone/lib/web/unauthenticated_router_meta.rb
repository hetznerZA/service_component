
        add_unsigned_unauthorized_route('/authorization-policy-is-anyone/get_latest_flow_identifier',
          "Test service that provides the last flow_identifier that was processed by authorization-policy-is-anyone") do |request|
          http_code, body = SoarSc::Web::Controllers::PolicyIsAnyoneController.new(@configuration).get_latest_flow_identifier(request)
          SoarSc::Web::Views::JSON.render(http_code, body)
        end

        add_unsigned_unauthorized_route('/authorization-policy-is-anyone',
          "Test service that provides a simple policy endpoint allowing any subject_identifier except 'nobody'") do |request|
          http_code, body = SoarSc::Web::Controllers::PolicyIsAnyoneController.new(@configuration).serve(request)
          SoarSc::Web::Views::JSON.render(http_code, body)
        end
