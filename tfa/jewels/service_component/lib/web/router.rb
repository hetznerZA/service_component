        add_unsigned_unauthorized_route('/service_component/notify',
          "Allow the test suite to notify arbitrary audit events in order to exercise the auditing on soar_sc") do |request|
          http_code, body = SoarSc::Web::Controllers::AuditNotifyTest.new(@configuration).serve(request)
          SoarSc::Web::Views::XML.render(http_code, body)
        end

        add_unsigned_unauthorized_route('/service_component/auditor',
          "Allow the test suite to pause, halt and view the reporting of audit events in the auditing buffer") do |request|
          http_code, body = SoarSc::Web::Controllers::AuditBufferTest.new(@configuration).serve(request)
          SoarSc::Web::Views::XML.render(http_code, body)
        end

        add_unsigned_unauthorized_route('/service_component/flow',
          "Allow the test suite to exercise the automatic generation and passing of flow identifiers") do |request|
          http_code, body = SoarSc::Web::Controllers::AuditFlowTest.new(@configuration).serve(request)
          SoarSc::Web::Views::XML.render(http_code, body)
        end

        register_route({
          'description' => 'Authorized test service with a registered existing policy ',
          'service_name' => 'architectural-test-service-with-registered-existing-policy',
          'path' => '/architectural-test-service-with-registered-existing-policy',
          'method' => 'get',
          'nfrs' => {
            'authorization' => 'AUTHORIZED',
            'secured' => 'UNSIGNED'
          },
          'view' => {
            'renderer' => 'json'
          },
          'controller' => 'ServiceRegistryTestController'
        })

        register_route({
          'description' => 'Authorized test service with a registered nonexisting policy',
          'service_name' => 'architectural-test-service-with-registered-nonexisting-policy',
          'path' => '/architectural-test-service-with-registered-nonexisting-policy',
          'method' => 'get',
          'nfrs' => {
            'authorization' => 'AUTHORIZED',
            'secured' => 'UNSIGNED'
          },
          'view' => {
            'renderer' => 'json'
          },
          'controller' => 'ServiceRegistryTestController'
        })

        register_route({
          'description' => 'Authorized test service with an unregistered existing policy',
          'service_name' => 'architectural-test-service-with-unregistered-existing-policy',
          'path' => '/architectural-test-service-with-unregistered-existing-policy',
          'method' => 'get',
          'nfrs' => {
            'authorization' => 'AUTHORIZED',
            'secured' => 'UNSIGNED'
          },
          'view' => {
            'renderer' => 'json'
          },
          'controller' => 'ServiceRegistryTestController'
        })

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
