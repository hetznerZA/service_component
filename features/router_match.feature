Feature: Routing requests to controllers
  As a service component
  When I have received requests
  In order to have appropriate controllers service the requests
  I want to accurately route the requests

  Scenario: Best match
    Given I am bootstrapped
    And a request for a service that match multiple controllers
    When I receive a request
    Then I match the path to registered controllers
    And I call the controller that match best

  Scenario: Single match
    Given I am bootstrapped
    And a request for a service that matches one controller
    When I receive a request
    Then I match the path to the controller
    And I call the controller

  Scenario: No match
    Given I am bootstrapped
    And a request for a service that matches no controller
    When I receive a request
    Then I attempt to match the path to registered controllers
    And I do not call a controller
    And I notify 'no match'

  Scenario: Match with REST
    Given I am bootstrapped
    And a request for a service with REST parametrized resource
    When I receive a request
    Then I match the path to the controller
    And I do not exclude parametrized resource matching in the design
    And I call the controller

  Scenario: No match with REST
    Given I am bootstrapped
    And a request for a service with REST parametrized resource
    And no controller matches the request directly
    When I receive a request
    Then I attempt to match the path to registered controllers
    And I do not exclude parametrized resource matching in the design
    And I notify 'no match'
