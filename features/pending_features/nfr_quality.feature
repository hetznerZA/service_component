Feature: Quality NFRs when fulfilling the quality architectural viewpoint
  As an Achitect
  In order to ensure quality of the architecture
  I want to be assured that the service components are of high quality

  Scenario: NFRs
    Given an architecture
    Then service components in the architecture must have NFRs specified

  Scenario: Features
    Given an architecture
    And a service component Architectural Building Block
    Then the service components ABB must have architectural features tested with BDD

  Scenario: Software design
    Given an architecture
    And a service component Architectural Building Block
    Then the service components ABB must have software design features built using TDD

  Scenario: Frameworks
    Given an architecture
    And a service component Architectural Building Block
    And the service component Architectural Building Block leverages frameworks
    Then the frameworks must be selected following a quality process

  Scenario: Tools
    Given an architecture
    And a service component Architectural Building Block
    Then the service component tool chain must be of sufficient quality
    And such quality is defined by developers using the tools
    And such tools may not hamper development progress


