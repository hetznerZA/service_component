Feature: Pluggable auditing provider
  As a service component
  In order to notify audit events
  I want an initialized auditing provider

Scenario:
  Given a valid auditing provider
  When I am bootstrapped
  Then I complete bootstrap
  And I have an initialized auditing provider

Scenario:
  Given a valid auditing provider
  And an auditing provider initialization failure
  When I am bootstrapped
  Then I do not complete bootstrap
  And I notify 'Failure initializing auditing provider'

Scenario:
  Given an invalid auditing provider
  When I am bootstrapped
  Then I do not complete bootstrap
  And I notify 'Failure initializing auditing provider'

#TODO testing the plugging of a provider vs the selection of an auditor?
