Feature: Bootstrapping with environment configuration file
  As a service component
  In order to retrieve my environment configuration
  I want to be bootstrapped
  With an environment file

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And a service identifier present in the environment file
    When I am bootstrapped
    Then I can extract the service identifier from the environment file

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And a service registry URI present in the environment file
    When I am bootstrapped
    Then I can extract the service registry URI from the environment file    

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And an authentication service URI present in the environment file
    When I am bootstrapped
    Then I can extract the authentication service URI from the environment file  

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And an execution environment indicator present in the environment file
    When I am bootstrapped
    Then I can extract the execution environment indicator from the environment file    

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And a configuration service URI present in the environment file
    When I am bootstrapped
    Then I can extract the configuration service URI from the environment file    

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And a configuration service token present in the environment file
    When I am bootstrapped
    Then I can extract the configuration service token from the environment file    

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And a configuration service provider present in the environment file
    When I am bootstrapped
    Then I can extract the configuration service provider from the environment file    

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And a session key present in the environment file
    When I am bootstrapped
    Then I can extract the session key from the environment file   

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And a session secret present in the environment file
    When I am bootstrapped
    Then I can extract the session secret from the environment file    

  Scenario:
    Given an environment file
    And the environment file is placed in an expected location
    And a failure reading the environment file
    When I am bootstrapped
    Then I notify 'failure retrieving environment from file'
    And I do not complete bootstrap 