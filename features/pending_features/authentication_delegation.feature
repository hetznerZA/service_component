Feature: Allowing delegation of authentication
  As a service component
  Given delegation of authentication
  In order to allow decisions around A&A
  I want to indicate identity delegation details

  Scenario:
    Given an authenticated identity
    And an originator of authentication delegation
    And a delegated request
    When I am asked whether the request has been delegated
    Then I respond true

  Scenario:
    Given an authenticated identity
    And no originator of authentication delegation
    And a request
    When I am asked whether the request has been delegated
    Then I respond false

  Scenario:
    Given an authenticated identity
    And an originator of authentication delegation
    And a delegated request
    When I am asked who delegated the authentication
    Then I respond with the identity of the originator

  Scenario:
    Given an authenticated identity
    And no originator of authentication delegation
    And a request
    When I am asked who delegated the authentication
    Then I respond with nil

  Scenario:
    Given a request
    And an authentication failure
    When I am asked who delegated the authentication
    Then I respond with nil
    And I notify 'Could not determine delegation'