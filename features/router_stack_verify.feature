  Scenario: verifying signed requests - known sender
    As a service component
    When I receive an signed request
    And I can identify the sender
    Then I look up credentials for the sender
    And I verify the request signature

  Scenario: verifying signed requests - invalid signature
    As a service component
    When I receive a signed request
    And I can identify the sender
    And the message is not signed by the sender
    Then I look up credentials for the sender
    And I notify 'Cannot decrypt request- invalid signature'

  Scenario: verifying signed requests - unknown sender
    As a service component
    When I receive a signed request
    And I can not identify the sender
    Then I look up credentials for the sender
    Then I notify 'Cannot verify request signature - unknown sender'

  Scenario: decrypting requests - missing credentials
    As a service component
    When I receive a signed request
    And I cannot look up credentials for the sender
    Then I notify 'Cannot verify request signature - unknown sender'