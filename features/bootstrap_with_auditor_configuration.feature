Feature: Bootstrapping with auditor configuration
  As a service component
  In order to report audit events
  I want to be bootstrapped
  With auditor configuration

  Scenario:
    Given a valid auditor configuration
    When I am bootstrapped
    Then I remember the auditor configuration
    And I complete bootstrap

  Scenario:
    Given an invalid auditor configuration
    When I am bootstrapped
    Then I notify 'invalid auditor configuration'
    And I do not complete bootstrap

  Scenario:
    Given no auditor configuration
    When I am bootstrapped
    Then I notify 'missing auditor configuration'
    And I do not complete bootstrap
