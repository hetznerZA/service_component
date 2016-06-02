Feature: Auditing service component actions
  As a service component
  In order to provide transparency
  I want to notify audit events

  Scenario:
    Given an audit event
    And a valid time
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the time

  Scenario:
    Given an audit event
    And a valid time
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the time as utc time

  Scenario:
    Given an audit event
    And a valid time
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the current utc time

  Scenario:
    Given an audit event
    And a invalid time
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the current utc time
    And I notify an auditing provider of the invalid time error
    And I provide the current utc time
