Feature: Bootstrapping with an execution environment indicator
  As a service component
  In order to behave appropriately in my execution environment
  I want to be bootstrapped
  With an execution environment indicator

  Scenario:
    Given a valid an execution environment indicator
    When I am bootstrapped
    Then I remember the execution environment indicator
    And I complete bootstrap

  Scenario:
    Given an invalid execution environment indicator
    When I am bootstrapped
    Then I notify 'Invalid execution environment indicator'
    And I do not complete bootstrap

  Scenario:
    Given no execution environment indicator
    When I am bootstrapped
    Then I notify 'Missing execution environment indicator'
    And I do not complete bootstrap
