Feature: Identifying authenticated identities
  As a service component
  In order to allow decisions around A&A
  I want to identify authenticated identities

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
    Then I respond with no authenticated identity

  Scenario:
    Given a request that does not require authentication
    And an authenticated identity
    When I am asked who has authenticated
    Then I respond with the authenticated identity's identifier in request not requiring authentication

  Scenario:
    Given a request that does not require authentication
    And no authenticated identity
    When I am asked who has authenticated
    Then I respond with no authenticated identity

  Scenario:
    Given a request
    And an authentication failure
    When I am asked who has authenticated
    Then I respond with no authenticated identity
    And I notify 'Failure determining authentication identity'
