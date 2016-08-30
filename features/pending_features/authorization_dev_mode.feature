Feature: Supporting development workflow authorization
  As a service component
  In order to facilitate development workflows
  I want to streamline authorization
  When in a development environment

  Scenario:
    Given an execution environment 'development'
    And an authenticated identity
    And an authorization policy
    When asked to authorize the service
    Then I respond with 'allow'

  Scenario:
    Given an execution environment 'development'
    And no authenticated identity
    And an authorization policy
    When asked to authorize the service
    Then I respond with 'allow'

  Scenario:
    Given an execution environment 'development'
    And an authorization policy
    And an authorization failure
    When asked to authorize the service
    Then I respond with 'deny'
    And I notify 'Failure authorizing'
