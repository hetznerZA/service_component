Feature: Bootstrapping with session configuration
  As a service component
  In order to support client sessions
  I want to be bootstrapped
  With session configuration

  Scenario:
    Given a valid session key
    And a valid session secret
    When I am bootstrapped
    Then I remember the session configuration
    And I complete bootstrap

  Scenario:
    Given an invalid session key
    And a valid session secret
    When I am bootstrapped
    Then I notify 'Invalid session key'
    And I do not complete bootstrap

  Scenario:
    Given no session key
    And a valid session secret
    When I am bootstrapped
    Then I notify 'Missing session key'
    And I do not complete bootstrap

  Scenario:
    Given a valid session key
    And an invalid session secret
    When I am bootstrapped
    Then I notify 'Invalid session secret'
    And I do not complete bootstrap

  Scenario:
    Given a valid session key
    And no session secret
    When I am bootstrapped
    Then I notify 'Missing session secret'
    And I do not complete bootstrap
