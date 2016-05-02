Feature: Auditing service component actions
  As a service component
  In order to provide transparency
  I want to notify actions and outcomes

  Scenario:
    Given an action or outcome
    And no auditing level
    When I am asked to audit
    Then I notify an auditing provider of the action or outcome
    And I provide my identifier
    And I default to 'debug' level

  Scenario:
    Given an action or outcome
    And an invalid auditing level
    When I am asked to audit
    Then I notify an auditing provider of the action or outcome
    And I provide my identifier
    And I default to 'debug' level
    And I notify 'Unknown auditing level'

  Scenario:
    Given an action or outcome
    And an auditing level 'debug'
    When I am asked to audit
    Then I notify an auditing provider of the action or outcome
    And I provide my identifier
    And I provide the selected auditing level

  Scenario:
    Given an action or outcome
    And an auditing level 'warn'
    When I am asked to audit
    Then I notify an auditing provider of the action or outcome
    And I provide my identifier
    And I provide the selected auditing level
    
  Scenario:
    Given an action or outcome
    And an auditing level 'error'
    When I am asked to audit
    Then I notify an auditing provider of the action or outcome
    And I provide my identifier
    And I provide the selected auditing level

  Scenario:
    Given an action or outcome
    And an auditing level 'info'
    When I am asked to audit
    Then I notify an auditing provider of the action or outcome
    And I provide my identifier
    And I provide the selected auditing level
    
  Scenario:
    Given no action nor outcome
    And a valid auditing level
    When I am asked to audit
    Then I notify an auditing provider with no action or outcome
    And I provide my identifier
    And I provide the selected auditing level

  Scenario:
    Given an action nor outcome
    And a valid auditing level
    And an auditing provider failure
    When I am asked to audit
    Then I notify 'auditing provider failure' on stderr
    And I notify using stderr with the action or outcome
