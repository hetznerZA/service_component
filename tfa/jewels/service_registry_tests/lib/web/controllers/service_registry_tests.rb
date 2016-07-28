require 'web/controllers/configured_controller'

module SoarSc
  module Web
    module Controllers
      class ServiceRegistryTestController < ConfiguredController
        def serve(request)
          reponse_body = {}

          if request['operation'] == 'remove-service-registry-client' then
            SoarSc::service_registry = nil
          end

          #for session tests we first populate the response body with the current information from the session and then set it to what we want
          reponse_body['returned_session_test_message'] = request.env['rack.session'][:test_message]
          request.env['rack.session'][:test_message]="Hello test suite"
          request.env['rack.session'][:rfc6265_provider]=request.env['rack.session'].class.to_s

          [200, reponse_body.to_json]
        end
      end
    end
  end
end
