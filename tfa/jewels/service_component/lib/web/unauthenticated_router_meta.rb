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

        add_unsigned_unauthorized_route('/routing-tests/endpoint-with-multiple-controllers',
          "Allow the test suite to exercise route matching") do |request|
          http_code, body = SoarSc::Web::Controllers::RoutingTestController.new(@configuration).serve_second_match(request)
          SoarSc::Web::Views::XML.render(http_code, body)
        end

        add_unsigned_unauthorized_route('/routing-tests/endpoint-with-multiple-controllers',
          "Allow the test suite to exercise route matching") do |request|
          http_code, body = SoarSc::Web::Controllers::RoutingTestController.new(@configuration).serve(request)
          SoarSc::Web::Views::XML.render(http_code, body)
        end

        add_unsigned_unauthorized_route('/routing-tests/endpoint-with-one-controller',
          "Allow the test suite to exercise route matching") do |request|
          http_code, body = SoarSc::Web::Controllers::RoutingTestController.new(@configuration).serve(request)
          SoarSc::Web::Views::XML.render(http_code, body)
        end

        add_unsigned_unauthorized_route('/routing-tests/endpoint-with-rest-parametrized-resource',
          "Allow the test suite to exercise route matching with REST parameter") do |request|
          http_code, body = SoarSc::Web::Controllers::RoutingTestController.new(@configuration).serve(request)
          SoarSc::Web::Views::XML.render(http_code, body)
        end

        add_unsigned_unauthorized_route('/endpoint-not-requiring-authentication',
          "Allow the test suite to exercise route matching with REST parameter") do |request|
          http_code, body = SoarSc::Web::Controllers::NoAuthenticationTestController.new(@configuration).serve(request)
          SoarSc::Web::Views::XML.render(http_code, body)
        end

        register_route({
          'description' => 'End point that results in delegation to another endpoint',
          'service_name' => 'architectural-test-service_that_will_result_in_delegation',
          'path' => '/architectural-test-service_backend_for_delegation_testing',
          'method' => 'get',
          'nfrs' => {
            'authorization' => 'UNAUTHORIZED',
            'secured' => 'UNSIGNED'
          },
         'view' => {
            'renderer' => 'json'
          },
          'controller' => 'DelegationTestControllerBackend'
        })
