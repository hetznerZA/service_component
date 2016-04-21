Feature: Bootstrapping with an authentication provider
  As a service component
  In order to authenticate requests
  I want to be bootstrapped
  With an authentication provider

  Scenario:
    Given a valid authentication provider
    When I am bootstrapped
    Then I remember the authentication provider
    And I complete bootstrap

  Scenario:
    Given an invalid authentication provider
    When I am bootstrapped
    Then I notify 'invalid authentication provider'
    And I do not complete bootstrap

  Scenario:
    Given no configuration
    When I am bootstrapped
    Then I notify 'missing authentication provider'
    And I do not complete bootstrap    