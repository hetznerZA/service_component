Feature: Pluggable authorization provider
  As a service component
  In order to authorize identities
  I want an initialized authorization provider

Scenario:
  Given a valid authorization provider
  When I am bootstrapped
  Then I have an initialized authorization provider

Scenario:
  Given a valid authorization provider
  And an authorization provider initialization failure
  When I am bootstrapped
  Then I notify 'Failure initializing authorization provider'
  And I do not complete bootstrap
