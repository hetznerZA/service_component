Feature: Bootstrapping with configuration service
  As a service component
  In order to retrieve my configuration
  I want to be bootstrapped
  With a configuration service URI
  And a configuration service token for my configuration

  Scenario:
    Given a valid configuration service URI
    And a configuration service identifier present
    And a valid configuration service token
    And the configuration service token is appropriate for my configuration
    When I am bootstrapped
    Then I retrieve my configuration
    And I complete bootstrap

  Scenario:
    Given an invalid configuration service URI
    And a configuration service identifier present
    And a valid configuration service token
    And the configuration service token is appropriate for my configuration
    When I am bootstrapped
    Then I notify 'invalid configuration service URI'
    And I do not complete bootstrap

  Scenario:
    Given no configuration service URI
    And a configuration service identifier present
    And no configuration file
    And a valid configuration service token
    And the configuration service token is appropriate for my configuration
    When I am bootstrapped
    Then I notify 'missing configuration service URI'
    And I do not complete bootstrap

  Scenario:
    Given a valid configuration service URI
    And a configuration service identifier present
    And a configuration service token string with a length of less than 12 characters
    And the configuration service token is appropriate for my configuration
    When I am bootstrapped
    Then I notify 'invalid configuration service token'
    And I do not complete bootstrap

  Scenario:
    Given a valid configuration service URI
    And a configuration service identifier present
    And no configuration service token
    And the configuration service token is appropriate for my configuration
    When I am bootstrapped
    Then I notify 'missing configuration service token'
    And I do not complete bootstrap

  Scenario:
    Given a valid configuration service URI
    And a configuration service identifier present
    And a valid configuration service token
    And the configuration service token is not appropriate for my configuration
    When I am bootstrapped
    Then I notify 'incorrect configuration service token'
    And I do not complete bootstrap

  Scenario:
    Given a valid configuration service URI
    And a configuration service identifier present
    And a valid configuration service token
    And the configuration service token is appropriate for my configuration
    And a failure retrieving my configuration
    When I am bootstrapped
    Then I notify 'failure retrieving configuration'
    And I do not complete bootstrap
