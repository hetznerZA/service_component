Feature: Pluggable auditing provider
  As a service component
  In order to notify actions and outcomes
  I want an initialized auditing provider

Scenario:
  Given a valid auditing provider
  When I am bootstrapped
  Then I have an initialized auditing provider

Scenario:
  Given a valid auditing provider
  And an auditing provider initialization failure
  When I am bootstrapped
  Then I notify 'Failure initializing auditing provider'
  And I do not complete bootstrap
