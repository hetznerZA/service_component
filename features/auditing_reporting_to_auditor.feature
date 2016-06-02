Feature: Reporting to auditor
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
    Then I report the oldest audit event
    And I remove the oldest audit event

  Scenario:
    Given a buffer with audit events
    When I cannot report to the auditor
    Then I do not repot to the auditor
    And I do not remove the oldest audit event
