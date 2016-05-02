Feature: Pluggable authentication provider
  As a service component
  In order to authenticate identities
  I want an initialized authentication provider

Scenario:
  Given a valid authentication provider
  When I am bootstrapped
  Then I have an initialized authentication provider

Scenario:
  Given a valid authentication provider
  And an authenticaton provider initialization failure
  When I am bootstrapped
  Then I notify 'Failure initializing authentication provider'
  And I do not complete bootstrap
