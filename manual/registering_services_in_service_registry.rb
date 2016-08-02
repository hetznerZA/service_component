#run in service_component root folder as follow:
#PUBLISH_PASSWORD=password bundle exec irb

#setup

require 'soar_sr'
credentials = { 'username' => 'uddi', 'password' => ENV['PUBLISH_PASSWORD'] }
freshness = 0
@services = SoarSr::ServiceRegistry.new('http://service-registry.auto-h.net:8080', 'hetzner.co.za', 'hetzner', credentials, freshness).services
@associations = SoarSr::ServiceRegistry.new('http://service-registry.auto-h.net:8080', 'hetzner.co.za', 'hetzner', credentials, freshness).associations

#Service registry policy related testing

service_name = 'authorization-policy-is-anyone'
@services.register_service( {'name' => service_name, 'description' => 'Policy allowing anyone, but not nobody' })
@services.add_service_uri(service_name, 'http://localhost:9393/authorization-policy-is-anyone/')
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

#Find service URI related testing

service_name = 'architectural-test-service-registered-with-0-uris'
@services.register_service( {'name' => service_name, 'description' => 'Test service with no access point uri' })
@associations.associate_service_with_domain_perspective(service_name, 'testing')

service_name = 'architectural-test-service-registered-with-1-uris'
@services.register_service( {'name' => service_name, 'description' => 'Test service with 1 access point uri' })
@services.add_service_uri(service_name, 'http://localhost:9393/architectural-test-service-access-point-1/')
@associations.associate_service_with_domain_perspective(service_name, 'testing')

service_name = 'architectural-test-service-registered-with-2-uris'
@services.register_service( {'name' => service_name, 'description' => 'Test service with 2 access point uris' })
@services.add_service_uri(service_name, 'http://localhost:9393/architectural-test-service-access-point-1/')
@services.add_service_uri(service_name, 'http://localhost:9393/architectural-test-service-access-point-2/')
@associations.associate_service_with_domain_perspective(service_name, 'testing')

service_name = 'architectural-test-service-registered-with-2-uris-some-unreachable'
@services.register_service( {'name' => service_name, 'description' => 'Test service with 2 access point uris but one unreachable' })
@services.add_service_uri(service_name, 'http://localhost:9393/architectural-test-service-access-point-unreachable/')
@services.add_service_uri(service_name, 'http://localhost:9393/architectural-test-service-access-point-2/')
@associations.associate_service_with_domain_perspective(service_name, 'testing')
