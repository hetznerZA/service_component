Feature: Auditing service component actions
  As a developer
  When I am supporting workflows
  In order to connect auditing events for a workflow across multiple services
  I want to link all service interactions for the workflow
  With a unique flow identifier

  Scenario:
    Given a request
    And the request has no flow identifier
    When the service component receives a request
    Then it should generate a unique flow identifier
    And update the request with the flow identifier

  Scenario:
    Given a request
    And the request has a flow identifier
    When the service component receives a request
    Then I want to use the flow identifier in auditing

  Scenario:
    Given a request
    And the request has a flow identifier
    When the service component receives a request
    And the service component need to talk to another service
    Then I want to use the flow identifier to identify the flow in the new request
