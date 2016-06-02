Feature: Auditing service component actions
  As a service component
  In order to ensure audit events are reported
  I want to buffer audit events

  Scenario:
    Given an audit event
    When I am asked to audit
    Then I add the audit event to the buffer

  Scenario:
    Given an audit event
    When I am asked to audit
    And the audit buffer is full
    Then I remove the oldest audit event from the buffer
    And I add the audit event to the buffer
