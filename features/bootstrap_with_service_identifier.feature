Feature: Bootstrapping with a service identifier
  As a service component
  In order to retrieve my configuration
  And identify myself with other service components
  I want to be bootstrapped
  With a service identifier

  Scenario:
    Given a valid service identifier
    And an environment configuration
    When I am bootstrapped
    Then I remember my service identifier
    And I complete bootstrap

  Scenario:
    Given an invalid service identifier
    And an environment configuration
    When I am bootstrapped
    Then I notify 'invalid service identifier'
    And I do not complete bootstrap

  Scenario:
    Given no service identifier
    And an environment configuration
    When I am bootstrapped
    Then I notify 'invalid service identifier'
    And I do not complete bootstrap    