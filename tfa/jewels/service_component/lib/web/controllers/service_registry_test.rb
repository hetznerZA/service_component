require 'web/controllers/configured_controller'

module SoarSc
  module Web
    module Controllers
      class ServiceRegistryTest < ConfiguredController
        def serve(request)
          if request['operation'] == 'notify' then
            SoarSc::auditing.send(request['level'].to_s,request['data'].to_s,request.params['flow_identifier'].to_s)
          end
          [200, ""]
        end
      end
    end
  end
end
