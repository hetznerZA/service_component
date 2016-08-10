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
