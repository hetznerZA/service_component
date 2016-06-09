Feature: Bootstrapping with CORS configuration
  As a service component
  In order to configure CORS
  I want to be bootstrapped with a CORS configuration

  Scenario:
    Given a valid session key
    And a valid session secret
    When I am bootstrapped
    Then I remember the session configuration
    And I complete bootstrap

  Scenario:
    Given an invalid session key
    And a valid session secret
    Then I notify 'invalid session key'
    And I do not complete bootstrap

  Scenario:
    Given no session key
    And a valid session secret
    Then I notify 'missing session key'
    And I do not complete bootstrap

  Scenario:
    Given an valid session key
    And an invalid session secret
    Then I notify 'invalid session secret'
    And I do not complete bootstrap

  Scenario:
    Given a valid session key
    And no session secret
    Then I notify 'missing session secret'
    And I do not complete bootstrap