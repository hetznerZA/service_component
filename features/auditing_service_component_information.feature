Feature: Auditing service component actions
  As a service component
  In order to provide transparency
  I want to associate audit events with myself

  Scenario:
    Given an audit event
    And an auditing level 'debug'
    When I am asked to audit
    Then I provide my identifier
