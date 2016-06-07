Feature: Auditing service component actions
  As a service component
  In order to report a noteworthy events
  I want to notify audit events

Scenario:
  Given an audit event
  When I am asked to audit
  Then I notify an auditing provider of the audit event
  And the audit event is correctly formatted
