Feature: Auditing service component actions
  As a service component
  In order to report events consistently
  I want to format audit events

Scenario:
  Given an audit event
  And a valid auditing level
  And a flow identifier
  When I am asked to audit
  Then I notify an auditing provider of the audit event
  And the audit event is correctly formatted
