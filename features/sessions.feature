Feature: Session support
  As a service component
  In order to facilitate transactions across separate request
  I want to facilitate state storage using sessions
  
  Scenario:
    Given a session client
    And a request
    Then this service component must not be less compliant to RFC 6265 than https://github.com/rack

  Scenario:
    Given a session client
    And a request
    And a session secret
    And a new session
    Then the session is encrypted using the secret

  Scenario:
    Given a session client
    And a request
    And a unique session key
    Then session interactions are persisted using the key

  Scenario:
    Given session support
    Then bootstrap validation ensures a session key is present

  Scenario:
    Given session support
    Then bootstrap validation ensures a session secret is present