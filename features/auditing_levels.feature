Feature: Auditing service component actions
  As a service component
  In order to provide transparency
  I want to notify levels in audit events

  Scenario:
    Given an audit event
    And no auditing level
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I default to 'debug' level

  Scenario:
    Given an audit event
    And an invalid auditing level
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
    And I default to 'debug' level
    And I notify 'Unknown auditing level'

  Scenario:
    Given an audit event
    And an auditing level 'debug'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the 'debug' auditing level

  Scenario:
    Given an audit event
    And an auditing level 'info'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the 'info' auditing level

  Scenario:
    Given an audit event
    And an auditing level 'warn'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the 'warn' auditing level

  Scenario:
    Given an audit event
    And an auditing level 'error'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the 'error' auditing level

  Scenario:
    Given an audit event
    And an auditing level 'fatal'
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the 'fatal' auditing level

  Scenario:
    Given no audit event
    And a valid auditing level
    When I am asked to audit
    Then I notify an auditing provider with no audit event
    And I provide the debug auditing level
