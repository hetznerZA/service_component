Feature: Policy lookup
  As a service component
  In order to facilitate authorization by policy
  I want to look up policies associated with services
    
  Scenario:
    Given a request for a service
    And a policy for the service exists
    And the policy is registered with the service
    When determining authorization for the service
    Then I ask the service registry for the service policy name

  Scenario:
    Given a request for a service
    And a policy for the service does not exists
    And the policy is registered with the service
    When determining authorization for the service
    Then I ask the service registry for the service policy name
    And I notify 'Could not find policy'

  Scenario:
    Given a request for a service
    And a policy for the service exists
    And the policy is not registered with the service
    When determining authorization for the service
    Then I notify 'No policy associated with service'

  Scenario:
    Given a request for a service
    And a policy for the service exists
    And the policy is registered with the service
    And a failure
    When determining authorization for the service
    Then I ask the service registry for the service policy name
    And I notify 'Could not retrieve policy for service'
