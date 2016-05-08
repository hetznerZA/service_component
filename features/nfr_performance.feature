Feature: Performance NFRs when fulfilling the performance architectural viewpoint
  As an Achitect
  In order to ensure performance of data and functionality
  I want to be assured that the service component supports performance access to and processing of data and functionality

  Scenario: Bootstrapping
    Given a service component
    When bootstrapping the component
    Then the bootstrap completes in a performant timeframe

  Scenario: State management
    Given a service component
    And it has been bootstrapped
    When keeping state
    Then the state is usable in a performant timeframe

  Scenario: Communication
    Given a service component
    And it has been bootstrapped
    When communicating
    Then the communication completes in a performant timeframe

  Scenario: Data access
    Given a service component
    And it has been bootstrapped
    When storing data
    Then the storage is accomplished in a performant timeframe
