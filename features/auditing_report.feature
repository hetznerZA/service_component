Feature: Auditing service component actions
  As a service component
  In order to report a noteworthy events
  I want to notify audit events

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    When I am asked to audit
    Then I notify an auditing provider of the audit event

  Scenario:
    Given an audit event
    And an auditing level 'debug'
    And a flow identifier
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the 'debug' auditing level

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the flow identifier

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    And a message
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the message
