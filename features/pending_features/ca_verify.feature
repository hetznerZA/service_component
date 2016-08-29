Feature: Validate certificate
  As a service component
  In order to have confidence in authentication identification
  I want to verify certificates
  Using a certificate authority

  Scenario:
    Given a valid certificate authority trust chain
    And a valid certificate authority verification URI
    And a valid certificate
    When asked to verify the certificate
    Then I ask the CA to verify the certificate
    And I ask the CA to present an updated revocation list
    And I notify verified

  Scenario:
    Given a valid certificate authority trust chain
    And a valid certificate authority verification URI
    And an invalid certificate
    When asked to verify the certificate
    Then I ask the CA to verify the certificate
    And I ask the CA to present an updated revocation list
    And I notify verification failure

  Scenario:
    Given a valid certificate authority trust chain
    And a valid certificate authority verification URI
    And no certificate
    When asked to verify the certificate
    Then I do not ask the CA to verify the certificate
    And I do not ask the CA to present an updated revocation list
    And I notify 'missing certificate'
    And I notify verification failure

  Scenario:
    Given a valid certificate authority trust chain
    And a valid certificate authority verification URI
    And a valid certificate
    And a certificate authority failure
    When asked to verify the certificate
    And I notify 'failure verifying certificate'
    And I notify verification failure

  Scenario:
    Given a valid certificate authority trust chain
    And a valid certificate authority verification URI
    And a valid certificate
    And a trust store failure
    When asked to verify the certificate
    Then I do not ask the CA to verify the certificate
    And I do not ask the CA to present an updated revocation list
    And I notify 'failure verifying certificate'
    And I notify verification failure

  Scenario:
    Given a valid certificate authority trust chain
    And a valid certificate authority verification URI
    And a revoked certificate
    When asked to verify the certificate
    Then I ask the CA to verify the certificate
    And I ask the CA to present an updated revocation list
    And I notify verification failure
