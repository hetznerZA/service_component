Feature: Supporting staging environment for applications
  As a developer
  In order to remove red tape when developing an application
  I want to indicate a staging execution environment
  And be supported in my staging

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then debugging tools should not be available

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then test tools should not be available

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then code coverate tools should not be available

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then authentication should not allow development access 

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then authentication should allow access to staging credentials

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then authentication should not allow production credential access 

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then authentication should only approve access based on credentials

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then authentication should indicate the actual authenticated identity

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then certificates should be required for authentication

Scenario:
  Given an execution environment 'staging'
  When I start the service component
  Then authorization should approve access based on staging policies

Scenario:
  Given an execution environment 'staging'
  When I try to deploy the service component
  Then deployment tools should warn me I am not in production mode