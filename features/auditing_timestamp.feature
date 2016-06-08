Feature: Auditing service component actions
  As a service component
  In order to support sequential analysis of events
  I want to notify timestamps in audit events

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the time

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the time as utc time
