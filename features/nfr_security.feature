Feature: Security NFRs when fulfilling the security architectural viewpoint
  As an Achitect
  In order to ensure security of data and functionality
  I want to be assured that the service component supports security measures that achieves data and functional security

  Scenario: Bootstrapping
    Given a service component
    When bootstrapping the component
    Then the bootstrap configuration is secure

  Scenario: State management
    Given a service component
    And it has been bootstrapped
    When keeping state
    Then the state is secure

  Scenario: Communicating
    Given a service component
    And it has been bootstrapped
    When communicating
    Then the communication is secure

  Scenario: Storing data
    Given a service component
    And it has been bootstrapped
    When storing data
    Then the storage is secure

  Scenario: Life-cycle
    Given a service component
    And it has been bootstrapped
    When terminating the service component
    Then the life-cycle is managed securely
