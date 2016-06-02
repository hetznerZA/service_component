Feature: Auditing service component actions
  As a service component
  In order to provide transparency
  I want to associate audit events with myself

  Scenario:
    Given an audit event
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide my identifier
