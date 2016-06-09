Feature: Ensuring CORS configuration applies
  As a service component
  In order to support the configuration of CORS
  I want to allow configured requests

  Scenario:
    Given a request that requires authentication
    And an authenticated human identity
    When I am asked who has authenticated
    Then I respond with the authenticated human identity's identifier

  Scenario:
    Given a request that requires authentication
    And an authenticated service identity
    When I am asked who has authenticated
    Then I respond with the authenticated service identity's identifier

  Scenario:
    Given a request that requires authentication
    And no authenticated identity
    When I am asked who has authenticated
    Then I respond with nil

  Scenario:
    Given a request that does not require authentication
    And an authenticated identity
    When I am asked who has authenticated
    Then I respond with the authenticated identity's identifier

  Scenario:
    Given a request that does not require authentication
    And no authenticated identity
    When I am asked who has authenticated
    Then I respond with nil

  Scenario:
    Given a request
    And an authentication failure
    When I am asked who has authenticated
    Then I respond with nil
    And I notify 'Failure determining authentication identity'

