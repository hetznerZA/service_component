        register_route({
          'description' => 'Access Point for command and control of service registry client in soar_sc',
          'service_name' => 'service-registry-client-command-and-control',
          'path' => '/service-registry-client-command-and-control',
          'method' => 'get',
          'nfrs' => {
            'authorization' => 'UNAUTHORIZED',
            'secured' => 'UNSIGNED'
          },
          'view' => {
            'renderer' => 'json'
          },
          'controller' => 'ServiceRegistryTestController'
        })

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

        register_route({
          'description' => 'Authorized test service access point 1',
          'service_name' => 'architectural-test-service-access-point-1',
          'path' => '/architectural-test-service-access-point-1',
          'method' => 'get',
          'nfrs' => {
            'authorization' => 'UNAUTHORIZED',
            'secured' => 'UNSIGNED'
          },
          'view' => {
            'renderer' => 'json'
          },
          'controller' => 'ServiceRegistryTestController'
        })

        register_route({
          'description' => 'Authorized test service access point 2',
          'service_name' => 'architectural-test-service-access-point-2',
          'path' => '/architectural-test-service-access-point-2',
          'method' => 'get',
          'nfrs' => {
            'authorization' => 'UNAUTHORIZED',
            'secured' => 'UNSIGNED'
          },
          'view' => {
            'renderer' => 'json'
          },
          'controller' => 'ServiceRegistryTestController'
        })

        register_route({
          'description' => 'Allow the test suite to view the authorization provider status',
          'service_name' => 'architectural-test-service-with-registered-existing-policy',
          'path' => 'authorization-tests/query-initialization-provider',
          'method' => 'get',
          'nfrs' => {
            'authorization' => 'AUTHORIZED',
            'secured' => 'UNSIGNED'
          },
          'view' => {
            'renderer' => 'json'
          },
          'controller' => 'AuthorizationTestController'
        })
