require 'soar_sr'

credentials = { 'username' => 'uddi', 'password' => 'get_from_vault' }
freshness = 0
@services = SoarSr::ServiceRegistry.new('http://service-registry.auto-h.net:8080', 'hetzner.co.za', 'hetzner', credentials, freshness).services
@associations = SoarSr::ServiceRegistry.new('http://service-registry.auto-h.net:8080', 'hetzner.co.za', 'hetzner', credentials, freshness).associations

service_name = 'authorization-policy-is-anyone'
@services.register_service( {'name' => service_name, 'description' => 'Policy allowing anyone, but not nobody' })
@services.add_service_uri(service_name, 'http://incubator.dev.auto-h.net:8080/authorization-policy-is-anyone/')
@associations.associate_service_with_domain_perspective(service_name, 'testing')

service_name = 'architectural-test-service-with-registered-existing-policy'
@services.register_service( {'name' => service_name, 'description' => 'Test service that has a registered existing policy' })
@services.configure_meta_for_service(service_name, {'policy' => 'authorization-policy-is-anyone'})
@associations.associate_service_with_domain_perspective(service_name, 'testing')

service_name = 'architectural-test-service-with-registered-nonexisting-policy'
@services.register_service( {'name' => service_name, 'description' => 'Test service that has a registered nonexisting policy' })
@services.configure_meta_for_service(service_name, {'policy' => 'authorization-policy-is-nonexisting'})
@associations.associate_service_with_domain_perspective(service_name, 'testing')

service_name = 'architectural-test-service-with-unregistered-existing-policy'
@services.register_service( {'name' => service_name, 'description' => 'Test service that does not have a registered policy' })
#No policy registered in the service meta for the purpose of the test
@associations.associate_service_with_domain_perspective(service_name, 'testing')
