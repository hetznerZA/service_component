Feature: Auditing service component actions
  As a service component
  In order to ensure audit events are reported
  I want to buffer audit events

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    When I am asked to audit
    Then I add the audit event to the buffer

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    And the audit buffer is full
    When I am asked to audit
    Then I remove the oldest audit event from the buffer
    And I add the audit event to the buffer
