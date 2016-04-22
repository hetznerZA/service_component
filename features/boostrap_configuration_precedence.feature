Feature: Configuration source precedence
  Scenario:
    Given a valid configuration service URI
    And a valid configuration service token
    And the configuration service token is appropriate for my configuration
    And a valid configuration file
    And the file is placed in an expected location
    When I am bootstrapped
    Then I retrieve my configuration from the configuration service only
    And I complete bootstrap
