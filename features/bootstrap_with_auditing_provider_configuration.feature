Feature: Bootstrapping with auditing provider configuration including auditing level
  As a service component
  In order to report audit events
  I want to be bootstrapped
  With auditing provider configuration

  Scenario:
    Given a valid auditing provider configuration
    When I am bootstrapped
    Then I remember the auditing provider configuration
    And I complete bootstrap

  Scenario:
    Given an invalid auditing provider configuration
    When I am bootstrapped
    Then I notify 'Invalid auditing provider configuration'
    And I do not complete bootstrap

  Scenario:
    Given no auditing provider configuration
    When I am bootstrapped
    Then I notify 'Missing auditing provider configuration'
    And I do not complete bootstrap

  Scenario:
    Given a valid configured auditing level
    When I am bootstrapped
    Then I remember the auditing level
    And I complete bootstrap

  Scenario:
    Given an invalid configured auditing level
    When I am bootstrapped
    Then I notify 'Invalid auditing level'
    And I do not complete bootstrap

  Scenario:
    Given no configured auditing level
    When I am bootstrapped
    Then I notify 'Missing auditing level'
    And I do not complete bootstrap
