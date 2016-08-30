Feature: Supporting development workflow authentication
  As a service component
  In order to facilitate development workflows
  I want to streamline authentication
  When in a development environment

  Scenario:
    Given an execution environment 'development'
    And an authenticated identity
    And a request requiring authentication
    When I am asked who has authenticated
    Then I respond with 'developer'

  Scenario:
    Given an execution environment 'development'
    And no authenticated identity
    And a request requiring authentication
    When I am asked who has authenticated
    Then I respond with 'developer'

  Scenario:
    Given an execution environment 'development'
    And an authentication failure
    When I am asked who has authenticated
    Then I respond with nil due to failure to determine authentication identity
    And I notify 'Failure determining authentication identity'

  Scenario:
    Given an execution environment 'development'
    And an originator of authentication delegation
    And a delegated request
    When I am asked who delegated the authentication
    Then I respond with 'developer'
