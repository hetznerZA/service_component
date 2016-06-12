Feature: Bootstrapping with CORS configuration
  As a service component
  In order to know how to support CORS requests
  I want to be bootstrapped with an optional CORS configuration

Scenario: Success In BootStrapping With CORS Configuration
  Given a valid CORS configuration
  When I am bootstrapping
  And successfully apply the CORS configuration
  Then I complete bootstrap 
  And I indicate 'success'

Scenario:  Invalid Configuration In BootStrapping With CORS
  Given an invalid CORS configuration
  When I am bootstrapping
  Then I fail to bootstrap
  And I indicate 'fail'
  And I notify 'invalid CORS configuration'

Scenario: Missing Configuration in Bootstrapping with CORS
  Given missing CORS configuration
  When I am bootstrapping
  Then I fail to bootstrap
  And I indicate 'fail'
  And I notify 'missing CORS configuration'

Scenario: Failure In BootStrapping With CORS Configuration
  Given a valid CORS configuration
  And fail to apply the CORS configuration
  When I am bootstrapping
  Then I fail to bootstrap
  And I indicate 'fail'
  And I notify 'failure in bootstrapping CORS configuration'

Scenario: Unexpected Exception In BootStrapping With Configuration
  Given a valid CORS configuration
  And an unexpected occurrs
  When I am bootstrapped
  Then I fail to bootstrap 
  And I indicate 'fail'
  And I notify 'unexpected error in bootstrapping CORS confguration'
