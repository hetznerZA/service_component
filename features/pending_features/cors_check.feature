Feature: Ensuring CORS configuration applies
  As a service component
  In order to support resource sharing
  I want to support the CORS standard headers

  Scenario: Success In Requests That Match Configured CORS Ruleset
    Given a valid CORS configuration
    And specific ruleset
    When a request requires cross-origin resource sharing
    And it matches the specific ruleset
    Then I grant access to the resource

  Scenario: Success In Requests That Fail To Match Configured CORS Ruleset
    Given a valid CORS configuration
    And specific ruleset
    When a request requires cross-origin resource sharing
    And it does not match the specific ruleset
    Then I deny access to the resource

