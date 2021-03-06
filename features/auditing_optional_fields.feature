Feature: Auditing service component actions
  As a service component
  In order to provide flexibility
  I want to provide optional fields to audit events

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    And an optional field
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the optional field

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    And an empty optional field
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide the empty optional field

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    And no optional field
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I provide no optional field

  Scenario:
    Given an audit event
    And a valid auditing level
    And a flow identifier
    And an invalid optional field
    When I am asked to audit
    Then I notify an auditing provider of the audit event
    And I treat the option field as normal message text
