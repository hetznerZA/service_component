Feature: Bootstrapping with CORS configuration
  As a service component
  In order to know how to support CORS requests
  I want to be bootstrapped with an optional CORS configuration

Scenario: Success In BootStrapping With CORS Configuration
  Given a valid configuration
  And cors configuration
  When I am bootstrapped
  And successfully apply the CORS configuration
  Then I complete bootstrap 
  And I indicate 'success'

Scenario: Success In BootStrapping Without CORS Configuration
  Given a valid configuration
  And no cors configuration
  When I am bootstrapped
  Then I complete bootstrap 

Scenario: Failure In BootStrapping With CORS Configuration
  Given a valid configuration
  And cors configuration
  When I am bootstrapped
  And successfully apply the CORS configuration
  Then I complete bootstrap 
  And I indicate 'success'