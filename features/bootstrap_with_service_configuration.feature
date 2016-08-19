Feature: Bootstrapping with a configuration
  As a service component
  In order to adapt my operation based on configuration
  I want to be bootstrapped
  With a configuration

  Scenario:
    Given a valid configuration
    When I am bootstrapped
    Then I remember my configuration
    And I complete bootstrap

  Scenario:
    Given an invalid configuration
    When I am bootstrapped
    Then I notify 'Invalid configuration'
    And I do not complete bootstrap

  Scenario:
    Given no configuration
    When I am bootstrapped
    Then I notify 'missing configuration'
    And I do not complete bootstrap
