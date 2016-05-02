Feature: Disallowing unauthenticated access
  As a service component
  In order to allow decisions around A&A
  I want to indicate whether an identity has not authenticated

  Scenario:
    Given no authenticated identity
    And a request
    When I am asked whether the request has authenticated
    Then I respond false

  Scenario:
    Given an authenticated identity
    And a request
    And an authentication failure
    When I am asked whether the request has authenticated
    Then I respond false
    And I notify 'Failure determining authentication identity'
    

