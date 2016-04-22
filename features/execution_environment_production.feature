Feature: Supporting production environment for applications
  As a developer
  In order to remove red tape when developing an application
  I want to indicate a production execution environment
  And be supported in my production

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then debugging tools should not be available

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then test tools should not be available

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then code coverate tools should not be available

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then authentication should not allow development access 

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then authentication should allow access to production credentials

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then authentication should not allow staging credential access 

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then authentication should only approve access based on credentials

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then authentication should indicate the actual authenticated identity

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then certificates should be required for authentication

Scenario:
  Given an execution environment 'production'
  When I start the service component
  Then authorization should approve access based on production policies