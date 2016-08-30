Feature: Routing stack
  As a service component
  In order to route requests
  I want to use a routing stack

  Scenario: decrypting requests - known sender
    As a service component
    When I receive an encrypted request
    And I can identify the sender
    Then I look up credentials for the sender
    And I decrypt the request

  Scenario: decrypting requests - failure
    As a service component
    When I receive an encrypted request
    And I can identify the sender
    And the message is corrupt
    Then I look up credentials for the sender
    And I notify 'Cannot decrypt request- corrupted'

  Scenario: decrypting requests - unknown sender
    As a service component
    When I receive an encrypted request
    And I can not identify the sender
    Then I look up credentials for the sender
    Then I notify 'Cannot decrypt request- unknown sender'

  Scenario: decrypting requests - missing credentials
    As a service component
    When I receive an encrypted request
    Then I cannot look up credentials for the sender
    And I notify 'Cannot decrypt request- missing credentials'

