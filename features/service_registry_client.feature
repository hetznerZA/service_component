Feature: Service registry client providing full suite of service registry functionality
  As a service component
  In order to engage with a service registry
  I want to have an initialized service registry client

Scenario:
  Given a valid service registry URI
  And a service registry client provider
  When I am bootstrapped
  Then I have an initialized service registry client
  And the client has the full suite of service registry functionality

Scenario:
  Given a valid service registry URI
  And no service registry client provider
  When I am bootstrapped
  Then I notify 'Missing service registry client'
  And I do not complete bootstrap

Scenario:
  Given a valid service registry URI
  And a service registry client provider
  And a service registry client initialization failure
  When I am bootstrapped
  Then I notify 'Service registry client failure'
  And I do not complete bootstrap
