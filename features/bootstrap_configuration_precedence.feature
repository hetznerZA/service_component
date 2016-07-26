Feature: Configuration source precedence
  Scenario:
    Given a valid configuration service URI
    And a valid configuration service token
    And a configuration service identifier present
    And the configuration service token is appropriate for my configuration
    And a valid configuration file
    And the configuration file is placed in an expected location
    When I am bootstrapped
    Then I retrieve my configuration from the configuration service only
    And I complete bootstrap
