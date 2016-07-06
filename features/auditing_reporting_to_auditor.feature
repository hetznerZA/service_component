Feature: Auditing service component actions
  As a service component
  In order to report audit events
  I want to report buffered audit events

  Scenario:
    Given an empty buffer
    When I can report to the auditor
    Then I do not report to auditor

  Scenario:
    Given a buffer with audit events
    When I can report to the auditor
    Then I report the oldest audit event from the buffer
    And I remove the oldest audit event from the buffer

  Scenario:
    Given a buffer with audit events
    When I cannot report to the auditor
    Then I do not report to auditor
    And I do not remove the oldest audit event from the buffer

  Scenario:
    Given a buffer with audit events
    When a shutdown is initiated
    And I can report to the auditor
    Then I report the buffer to the auditor

  Scenario:
    Given a buffer with audit events
    When a shutdown is initiated
    And I cannot report to any auditor
    Then I report the buffer to standard error stream
