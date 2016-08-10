Feature: Bootstrapping with environment configuration
  As a service component
  In order to retrieve my environment configuration
  I want to be bootstrapped
  With an environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And a service identifier present in the environment
    When I am bootstrapped
    Then I can extract the service identifier from the environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And a service registry URI present in the environment
    When I am bootstrapped
    Then I can extract the service registry URI from the environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And an authentication service URI present in the environment
    When I am bootstrapped
    Then I can extract the authentication service URI from the environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And an execution environment indicator present in the environment
    When I am bootstrapped
    Then I can extract the execution environment indicator from the environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And a configuration service URI present in the environment
    When I am bootstrapped
    Then I can extract the configuration service URI from the environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And a configuration service token present in the environment
    When I am bootstrapped
    Then I can extract the configuration service token from the environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And a configuration service provider present in the environment
    When I am bootstrapped
    Then I can extract the configuration service provider from the environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And a session key present in the environment
    When I am bootstrapped
    Then I can extract the session key from the environment

  Scenario:
    Given an environment
    And environment can be loaded from system process
    And a session secret present in the environment
    When I am bootstrapped
    Then I can extract the session secret from the environment
