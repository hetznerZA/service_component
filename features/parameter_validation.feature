Feature: Validating request parameters
  As a service component
  When I have received requests
  In order to ensure the requests contain appropriate parameters
  I want to validate the parameters

  Scenario:
    Given a request
    And valid request parameters
    And a routing that does not specify parameters
    When I receive a request
    Then I allow the request to be routed to the controller

  Scenario:
    Given a request
    And invalid request parameters
    And a routing that does not specify parameters
    When I receive a request
    Then I allow the request to be routed to the controller

  Scenario:
    Given a request
    And valid request parameters
    And a routing that specify non-required parameters
    When I receive a request
    Then I allow the request to be routed to the controller

  Scenario:
    Given a request
    And invalid request parameters
    And a routing that specify non-required parameters
    When I receive a request
    Then I allow the request to be routed to the controller

  Scenario:
    Given a request
    And valid request parameters
    And a routing that specify required parameters
    When I receive a request
    Then I allow the request to be routed to the controller

  Scenario:
    Given a request
    And invalid request parameters
    And a routing that specify required parameters
    When I receive a request
    Then I reject the request due to invalid request parameters
