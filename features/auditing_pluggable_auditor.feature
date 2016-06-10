Feature: Pluggable auditors
  As a service component
  In order to notify audit events
  I want an initialized auditor

Scenario:
  Given a valid auditor
  When I am bootstrapped
  Then I complete bootstrap
  And I have an initialized auditor

Scenario:
  Given a valid auditor
  And an auditor initialization failure
  When I am bootstrapped
  Then I do not complete bootstrap
  And I notify 'Failure initializing auditor'

Scenario:
  Given an invalid auditor
  When I am bootstrapped
  Then I do not complete bootstrap
  And I notify 'Failure initializing auditor'

#TODO kyk na auditor tests in bootstrap
