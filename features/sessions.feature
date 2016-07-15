Feature: Session support
  As a service component
  In order to facilitate transactions across separate request
  I want to facilitate state storage using sessions

  Scenario:
    Given a session client
    And a request
    Then this service component must not be less compliant to RFC 6265 than https://github.com/rack

  Scenario:
    Given sessions use is undefined
    When I am bootstrapped
    Then I notify 'Undefined USE_SESSIONS value'
    And I do not complete bootstrap

  Scenario:
    Given sessions use is invalid
    When I am bootstrapped
    Then I notify 'Invalid USE_SESSIONS value'
    And I do not complete bootstrap

  Scenario:
    Given sessions are not used
    When I am bootstrapped
    Then I notify 'Not using sessions'
    And I complete bootstrap

  Scenario:
    Given sessions are not used
    And a request
    When the service component receives a request
    Then a session is not used when servicing the request

  Scenario:
    Given sessions are used
    And no session key is present
    When I am bootstrapped
    Then I notify 'Missing session key'
    And I do not complete bootstrap

  Scenario:
    Given sessions are used
    And no session secret is present
    When I am bootstrapped
    Then I notify 'Missing session secret'
    And I do not complete bootstrap

  Scenario:
    Given sessions are used
    And session key is invalid
    When I am bootstrapped
    Then I notify 'Invalid session key'
    And I do not complete bootstrap

  Scenario:
    Given sessions are used
    And session secret is invalid
    When I am bootstrapped
    Then I notify 'Invalid session secret'
    And I do not complete bootstrap

  Scenario:
    Given sessions are used
    And a request
    And a session secret
    When the service component receives a request
    Then the session is encrypted using the secret

  Scenario:
    Given sessions are used
    And a request
    And a unique session key
    When the service component receives a request
    Then session interactions are persisted using the key
