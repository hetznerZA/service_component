Feature: Allowing authenticated access
  As a service component
  In order to allow decisions around A&A
  I want to indicate whether an identity has authenticated

  Scenario:
    Given an authenticated identity
    And a request
    When I am asked whether the request has authenticated
    Then I respond true

  Scenario:
    Given an authenticated identity
    And a request
    When I am asked whether the request has authenticated
    Then I respond true
