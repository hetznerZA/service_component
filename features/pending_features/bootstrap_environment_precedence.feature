Feature: Environment source precedence
  Scenario:
    Given an environment configuration setting in the environment
    And the same environment configuration setting in the environment file
    When I am bootstrapped
    Then I choose the environment setting from the environment over the setting in the file

  Scenario:
    Given an environment configuration setting in the environment
    And a different environment configuration setting in the environment file
    When I am bootstrapped
    Then I choose both environment settings
