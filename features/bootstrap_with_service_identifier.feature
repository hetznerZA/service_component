Feature: Bootstrapping with a service identifier
  As a service component
  In order to retrieve my configuration
  And identify myself with other service components
  I want to be bootstrapped
  With a service identifier

  Scenario:
    Given an environment configuration
    And a valid service identifier
    When I am bootstrapped
    Then I remember my service identifier
    And I complete bootstrap

  Scenario:
    Given an environment configuration
    And an invalid service identifier
    When I am bootstrapped
    Then I notify 'invalid service identifier'
    And I do not complete bootstrap

  Scenario:
    Given an environment configuration
    And no service identifier
    When I am bootstrapped
    Then I notify 'invalid service identifier'
    And I do not complete bootstrap
