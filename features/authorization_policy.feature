Feature: Authorization policies
  As a service component
  In order to apply an authorization rule set
  I want to interpret and apply authorization policies

  Scenario:
    Given a request for a service
    And an authorization policy that approves
    When asked to authorize the service
    Then I apply the policy
    And I respond with 'allow'

  Scenario:
    Given a request for a service
    And an authorization policy that does not approve
    When asked to authorize the service
    Then I apply the policy
    And I respond with 'deny'

  Scenario:
    Given a request for a service
    And no authorization policy
    When asked to authorize the service
    Then I do not apply a policy
    And I respond with 'allow'

  Scenario:
    Given a request for a service
    And an authorization policy
    And an authorization failure
    When asked to authorize the service
    Then I respond with 'deny'
    And I notify 'Authorization failure'
