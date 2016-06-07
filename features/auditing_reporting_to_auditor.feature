Feature: Auditing service component actions
  As a service component
  In order to report audit events
  I want to report buffered audit events

  Scenario:
    Given a empty buffer
    When I can report to the auditor
    Then I do not report to auditor

  Scenario:
    Given a buffer with audit events
    When I can to report to auditor
    Then I report the oldest audit event from the buffer
    And I remove the oldest audit event from the buffer

  Scenario:
    Given a buffer with audit events
    When I cannot report to the auditor
    Then I do not report to auditor
    And I do not remove the oldest audit event from the buffer
