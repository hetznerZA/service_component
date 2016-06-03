Feature: Traceability of auditing events
  As a developer
  When I am supporting workflows
  In order to connect auditing events for a workflow across multiple services
  I want to link all service interactions for the workflow
  With a unique flow identifier

  Scenario:
    When I receive a request
    And the request does not have a flow identifier
    Then I want to generate a unique flow identifier
    And I want to update the request with the flow identifier

  Scenario:
    When I receive a request
    And the request has a flow identifier
    Then I want to use the flow identifier in auditing

  Scenario:
    When I have a request with a flow identifier
    And I need to talk to another service
    Then I want to use the flow identifier to identify the flow in the new request
