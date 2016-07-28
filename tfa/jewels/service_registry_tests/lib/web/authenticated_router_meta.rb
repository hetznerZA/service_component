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
