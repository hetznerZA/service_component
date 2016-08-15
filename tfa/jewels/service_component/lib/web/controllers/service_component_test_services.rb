require 'web/controllers/configured_controller'

module SoarSc
  module Web
    module Controllers
      class AuditNotifyTest < ConfiguredController
        def serve(request)
          if request['operation'] == 'notify' then
            SoarSc::auditing.send(request['level'].to_s,request['data'].to_s,request.params['flow_identifier'].to_s)
          end
          [200, ""]
        end
      end

      class AuditBufferTest < ConfiguredController
        def serve(request)
          if request['operation'] == 'select_default_auditor' then
            SoarSc::auditing.select_auditor(SoarSc::configuration['auditing']['default_nfrs'])
            $stderr.puts "--------------- SELECTING DEFAULT AUDITOR ---------------"
            return [200, ""]
          end
          if request['operation'] == 'select_rejecting_auditor' then
            SoarSc::auditing.select_auditor(SoarSc::configuration['auditing']['default_nfrs'].dup.merge('accessibility' => 'rejecting'))
            $stderr.puts "--------------- SELECTING REJECTING AUDITOR ---------------"
            return [200, ""]
          end
          [400, ""]
        end
      end

      class AuditFlowTest < ConfiguredController
        def serve(request)
          SoarSc::auditing.debug("#{request['data'].to_s}-#{request['operation'].to_s}-#{request['correlation_identifier'].to_s}",request.params['flow_identifier'].to_s)
          if request['operation'] == 'flow-test-action-1' then
            request['operation'] = 'flow-test-action-2'

            unauthenticated_meta = SoarSc::Web::UnauthenticatedRouterMeta.new(SoarSc::configuration)
            unauthenticated_router = SoarSc::Web::BaseRouter.new(unauthenticated_meta)
            unauthenticated_router.route(request)
          end
          [200, ""]
        end
      end

      class RoutingTestController < ConfiguredController
        def serve(request)
          SoarSc::auditing.debug("RoutingTestFirstController with path as #{request.path}",request.params['flow_identifier'].to_s)
          [200, ""]
        end
        def serve_second_match(request)
          SoarSc::auditing.debug("RoutingTestSecondController",request.params['flow_identifier'].to_s)
          [200, ""]
        end
      end
    end
  end
end
