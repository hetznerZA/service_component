Feature: Bootstrapping with a service registry
  As a service component
  In order to make good decisions about dependencies
  I want to be bootstrapped
  With a service registry URI

  Scenario:
    Given a valid service registry URI
    When I am bootstrapped
    Then I remember the service registry URI
    And I complete bootstrap

  Scenario:
    Given an invalid service registry URI
    When I am bootstrapped
    Then I notify 'invalid service registry URI'
    And I do not complete bootstrap

  Scenario:
    Given no service registry URI
    When I am bootstrapped
    Then I notify 'missing service registry URI'
    And I do not complete bootstrap    