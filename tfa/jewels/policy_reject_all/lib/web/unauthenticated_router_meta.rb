
        add_unsigned_unauthorized_route('/authorization-policy-reject-all/get_latest_flow_identifier',
          "Test service that provides the last flow_identifier that was processed by authorization-policy-reject-all") do |request|
          http_code, body = SoarSc::Web::Controllers::PolicyRejectAllController.new(@configuration).get_latest_flow_identifier(request)
          SoarSc::Web::Views::JSON.render(http_code, body)
        end
        
        register_route({
          'description' => "Test service that provides a simple policy endpoint rejecting any subject_identifier",
          'service_name' => 'service-server.dev.auto-h.net',
          'path' => '/authorization-policy-reject-all/',
          'method' => 'post',
          'nfrs' => {
            'authorization' => 'UNAUTHORIZED',
            'secured' => 'UNSIGNED'
          },
          'view' => {
            'renderer' => 'json'
          },
          'controller' => 'PolicyRejectAllController'
        })
