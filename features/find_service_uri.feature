Feature: Finding service URIs
  As a service component
  In order to make requests to appropriate services
  I want to find service URIs

  Scenario:
    Given a service name
    And the service is registered in the service registry
    And the service has access points registered in the service registry
    When I am asked to find service URIs for that service
    Then I ask the service registry for access points for the service
    And I cache the first service URIs in the list of access points
    And I return the first service URIs in the list of access points the service registry returns

  Scenario:
    Given a service name
    And the service is registered in the service registry
    And no access points for that service in the service registry
    When I am asked to find service URIs for that service
    Then I ask the service registry for access points for the service
    And I cache nil
    And I return nil

  Scenario:
    Given a service name
    And the service is not registered in the service registry
    When I am asked to find service URIs for that service
    Then I ask the service registry for access points for the service
    And I do not cache nil
    And I return nil

  Scenario:
    Given a service name
    And the service is registered in the service registry
    And the service has access points registered in the service registry
    And I have cached the answer before
    When I am asked to find service URIs for that service
    Then I return the cached value

  Scenario:
    Given a service name
    And the service is registered in the service registry
    And the service has access points registered in the service registry
    And I have cached the answer before
    And a service registry failure
    When I am asked to find service URIs for that service
    Then I return the cached value

  Scenario:
    Given a service name
    And the service is registered in the service registry
    And the service has access points registered in the service registry
    And I have not cached the answer before
    And a service registry failure
    When I am asked to find service URIs for that service
    Then I do not cache nil
    And I return nil
    And I notify 'Failure to look up service in service registry'

  Scenario:
    Given a service name
    And the service is registered in the service registry
    And the service has multiple access points registered in the service registry
    When I am asked to find the best service URIs for that service
    Then I ask the service registry for access points for the service
    And I ask the services for their functional status
    And I return the service URI for which the best functional status was obtained
    And I do not cache

  Scenario:
    Given a service name
    And the service is registered in the service registry
    And the service has multiple access points registered in the service registry
    And some of the access points are unreachable
    When I am asked to find the best service URIs for that service
    Then I ask the service registry for access points for the service
    And I ask the services for their functional status
    And I return the service URI for which the best functional status was obtained
    And I do not cache
    And I answer in no more than 2 seconds
