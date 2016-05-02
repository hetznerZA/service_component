Feature: Supporting development workflow authorization
  As a service component
  In order to facilitate development workflows
  I want to streamline authorization
  When in a development environment

  Scenario:
    Given an execution environment 'development'
    And an authenticated identity
    And a request requiring authorization
    When I am asked to authorize
    Then I respond with 'allow'

  Scenario:
    Given an execution environment 'development'
    And no authenticated identity
    And a request requiring authorization
    When I am asked to authorize
    Then I respond with 'allow'

  Scenario:
    Given an execution environment 'development'
    And an authorization failure
    When I am asked to authorize
    Then I respond with 'deny'
    And I notify 'Failure authorizing'