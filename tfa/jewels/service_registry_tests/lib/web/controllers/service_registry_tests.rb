require 'web/controllers/configured_controller'

module SoarSc
  module Web
    module Controllers
      class ServiceRegistryTestController < ConfiguredController
        def serve(request)
          reponse_body = {}

          if request['operation'] == 'remove-service-registry-client' then
            SoarSc::service_registry = nil
            return [200, reponse_body.to_json]
          end

          if request['operation'] == 'find_first_service_uri' then
            service_registry_response = SoarSc::Providers::ServiceRegistry.find_first_service_uri(request['service'])
            return [200, { 'service_registry_response' => service_registry_response, 'service_registry_meta' => get_service_registry_meta_after_request}]
          end

          if request['operation'] == 'find_best_service_uri' then
            service_registry_response = SoarSc::Providers::ServiceRegistry.find_best_service_uri(request['service'])
            return [200, { 'service_registry_response' => service_registry_response, 'service_registry_meta' => get_service_registry_meta_after_request}]
          end

          #for session tests we first populate the response body with the current information from the session and then set it to what we want
          reponse_body['returned_session_test_message'] = request.env['rack.session'][:test_message]
          request.env['rack.session'][:test_message]="Hello test suite"
          request.env['rack.session'][:rfc6265_provider]=request.env['rack.session'].class.to_s

          [200, reponse_body.to_json]
        end

        def get_service_registry_meta_after_request
          { 'cache_key_value_pairs' => get_service_registry_cache_key_value_pairs }
        end

        def get_service_registry_cache_key_value_pairs
          collection = {}
          keys = get_service_registry_cache.keys[0]
          if not keys.nil?
            keys.each do | k |
              collection[k] = get_service_registry_cache[k]
            end
          end
          collection
        end

        def get_service_registry_cache
          SoarSc::service_registry.instance_variable_get(:@uddi).cache
        end
      end
    end
  end
end
