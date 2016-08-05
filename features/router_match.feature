Feature: Routing requests to controllers
  As a service component
  When I have received requests
  In order to have appropriate controllers service the requests
  I want to accurately route the requests

  Scenario: Best match
    Given I am bootstrapped
    When I receive a request
    And multiple controllers match the request
    Then I match the path to registered controllers
    And I call the controller that match best

  Scenario: Single match
    Given I am bootstrapped
    When I receive a request
    And one controller matches the request
    Then I match the path to the controller
    And I call the controller

  Scenario: No match
    Given I am bootstrapped
    When I receive a request
    And no controller matches the request
    Then I attempt to match the path to registered controllers
    And I do not call a controller
    And I notify 'no match'

  Scenario: REST
    Given I am bootstrapped
    When I receive a REST parametrized resource request
    And no controller matches the request directly
    Then I attempt to match the path to registered controllers
    And I do not exclude parametrized resource matching in the design
    And I notify 'no match'
