Feature: Supporting development environment for applications
  As a developer
  In order to remove red tape when developing an application
  I want to indicate a development execution environment
  And be supported in my development

Scenario:
  Given no execution environment
  When I start the service component
  Then the execution environment should default to 'development'

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then debugging tools should be available for real-time debugging

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then test tools should be available for testing

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then code coverate tools should be available for coverage tracking

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then authentication should allow development access

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then authentication should not allow production credentials

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then authentication should always approve access

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then authentication should indicate 'developer' as the authenticated identity

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then certificates should not be required for authentication

Scenario:
  Given an execution environment 'development'
  When I start the service component
  Then authorization should always approve access

Scenario:
  Given an execution environment 'development'
  When I try to deploy the service component
  Then deployment tools should warn me I am not in production mode
