Feature: Bootstrapping with a certificate authority
  As a service component
  In order to verify certificates
  I want to be bootstrapped
  With a certificate authority trust chain
  And a certificate authority verification URI
  And a certificate revokation list URI

  Scenario:
    Given a valid certificate authority trust chain
    And a valid certificate authority verification URI
    When I am bootstrapped
    Then I remember the configuration
    And I complete bootstrap

  Scenario:
    Given an invalid certificate authority trust chain
    And a valid certificate authority verification URI
    And a valid certificate revokation list URI
    When I am bootstrapped
    Then I notify 'invalid certificate authority trust chain'
    And I do not complete bootstrap

  Scenario:
    Given a valid certificate authority trust chain
    And an invalid certificate authority verification URI
    And a valid certificate revokation list URI
    When I am bootstrapped
    Then I notify 'invalid certificate authority verification URI'
    And I do not complete bootstrap

  Scenario:
    Given a valid certificate authority trust chain
    And an valid certificate authority verification URI
    And a invalid certificate revokation list URI
    When I am bootstrapped
    Then I notify 'invalid certificate revokation list URI'
    And I do not complete bootstrap

  Scenario:
    Given no certificate authority trust chain
    And a valid certificate authority verification URI
    And a valid certificate revokation list URI
    When I am bootstrapped
    Then I notify 'missing certificate authority trust chain'
    And I do not complete bootstrap

  Scenario:
    Given a valid certificate authority trust chain
    And no certificate authority verification URI
    And a valid certificate revokation list URI
    When I am bootstrapped
    Then I notify 'missing authority verification URI'
    And I do not complete bootstrap

  Scenario:
    Given a valid certificate authority trust chain
    And a valid certificate authority verification URI
    And no certificate revokation list URI
    When I am bootstrapped
    Then I notify 'missing certificate revokation list URI'
    And I do not complete bootstrap
