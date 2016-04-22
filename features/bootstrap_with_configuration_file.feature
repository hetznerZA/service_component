Feature: Bootstrapping with configuration file
  As a service component
  In order to retrieve my configuration
  In the absence of a configuration service
  I want to be bootstrapped
  With a configuration file

  Scenario:
    Given a valid configuration file
    And the file is placed in an expected location
    And no configuration service
    When I am bootstrapped
    Then I retrieve my configuration from the file
    And I complete bootstrap

  Scenario:
    Given an invalid configuration file
    And the file is placed in an expected location
    And no configuration service
    When I am bootstrapped
    Then I notify 'invalid configuration file'
    And I do not complete bootstrap

  Scenario:
    Given a valid configuration file
    And a failure reading the configuration file
    When I am bootstrapped
    Then I notify 'failure retrieving configuration from file'
    And I do not complete bootstrap
