Given(/^a valid service identifier$/) do
  @test.given_valid_service_identifier_in_environment_file
end

Given(/^an environment configuration$/) do
  @test.given_environment_configuration
end

Given(/^environment can be loaded from system process$/) do
  expect(@test.given_environment_can_be_loaded_from_system_process).to eq(true)
end

When(/^I am bootstrapped$/) do
  @test.bootstrap
end

Then(/^I remember my service identifier$/) do
  expect(@test.has_remembered_service_identifier?).to eq(true)
end

Then(/^I complete bootstrap$/) do
  expect(@test.has_completed_bootstrap?).to eq(true)
end

Given(/^an invalid service identifier$/) do
  @test.given_invalid_service_identifier
end

Then(/^I notify 'invalid service identifier'$/) do
  expect(@test.audit_entry_with_message_exist?('invalid service identifier')).to eq(true)
end

Then(/^I do not complete bootstrap$/) do
  expect(@test.has_completed_bootstrap?).to eq(false)
end

Given(/^no service identifier$/) do
  @test.given_no_service_identifier
end

Given(/^an invalid service registry URI$/) do
  @test.given_invalid_service_registry_uri
end

Given(/^no service registry URI$/) do
  @test.given_no_service_registry_uri
end

Given(/^an environment file$/) do
  @test.given_an_environment_file
end

Given(/^the environment file is placed in an expected location$/) do
  @test.given_the_environment_file_is_placed_in_an_expected_location
end

Given(/^a service identifier present in the environment file$/) do
  @test.given_valid_service_identifier_in_environment_file
end

Given(/^a service registry URI present in the environment file$/) do
  @test.given_a_service_registry_uri_present_in_the_environment_file
end

Given(/^an authentication service URI present in the environment file$/) do
  @test.given_an_authentication_service_uri_present_in_the_environment_file
end

Given(/^an execution environment indicator present in the environment file$/) do
  @test.given_an_execution_environment_indicator_present_in_the_environment_file
end

Given(/^a configuration service URI present in the environment file$/) do
  @test.given_a_configuration_service_uri_present_in_the_environment_file
end

Given(/^a configuration service token present in the environment file$/) do
  @test.given_a_configuration_service_token_present_in_the_environment_file
end

Given(/^a configuration service identifier present$/) do
  @test.given_a_configuration_service_identifier_present
end

Given(/^a configuration service provider present in the environment file$/) do
  @test.given_a_configuration_service_provider_present_in_the_environment_file
end

Given(/^a session key present in the environment file$/) do
  @test.given_a_valid_session_key_in_environment_file
end

Given(/^a session secret present in the environment file$/) do
  @test.given_a_session_secret_in_environment_file
end

Given(/^a failure reading the environment file$/) do
  @test.given_a_failure_reading_the_environment_file
end

Given(/^a valid an execution environment indicator$/) do
  @test.given_a_valid_an_execution_environment_indicator
end

Given(/^an invalid execution environment indicator$/) do
  @test.given_an_invalid_execution_environment_indicator
end

Given(/^no execution environment indicator$/) do
  @test.given_no_execution_environment_indicator
end

Given(/^no execution environment$/) do
  @test.given_no_execution_environment
end

Given(/^an execution environment 'development'$/) do
  @test.given_an_development_execution_environment
end

Given(/^an execution environment 'production'$/) do
  @test.given_an_production_execution_environment
end

Given(/^an environment$/) do
  @test.given_an_environment
end

Given(/^a service identifier present in the environment$/) do
  @test.given_a_service_identifier_present_in_the_environment
end

Given(/^a service registry URI present in the environment$/) do
  @test.given_a_service_registry_uri_present_in_the_environment
end

Given(/^an authentication service URI present in the environment$/) do
  @test.given_an_authentication_service_uri_present_in_the_environment
end

Given(/^an execution environment indicator present in the environment$/) do
  @test.given_an_execution_environment_indicator_present_in_the_environment
end

Given(/^a configuration service URI present in the environment$/) do
  @test.given_a_configuration_service_uri_present_in_the_environment
end

Given(/^a configuration service token present in the environment$/) do
  @test.given_a_configuration_service_token_present_in_the_environment
end

Given(/^a configuration service provider present in the environment$/) do
  @test.given_a_configuration_service_provider_present_in_the_environment
end

Given(/^a session key present in the environment$/) do
  @test.given_a_valid_session_key_in_environment
end

Given(/^a session secret present in the environment$/) do
  @test.given_a_session_secret_in_environment
end

Given(/^a valid configuration service URI$/) do
  @test.given_a_valid_configuration_service_URI
end

Given(/^a valid configuration service token$/) do
  @test.given_a_valid_configuration_service_token
end

Given(/^the configuration service token is appropriate for my configuration$/) do
  @test.given_the_configuration_service_token_is_appropriate_for_my_configuration
end

Given(/^a valid configuration file$/) do
  @test.given_a_valid_configuration_file
end

Given(/^the configuration file is placed in an expected location$/) do
  @test.given_the_configuration_file_is_placed_in_an_expected_location
end

Given(/^no configuration service$/) do
  @test.given_no_configuration_service
end

Given(/^an invalid configuration file$/) do
  @test.given_an_invalid_configuration_file
end

Given(/^a failure reading the configuration file$/) do
  @test.given_a_failure_reading_the_configuration_file
end

Given(/^an invalid configuration service URI$/) do
  @test.given_an_invalid_configuration_service_uri
end

Given(/^no configuration service URI$/) do
  @test.given_no_configuration_service_uri
end

Given(/^no configuration file$/) do
  @test.given_no_configuration_file
end

Given(/^a configuration service token string with a length of less than (\d+) characters$/) do |arg1|
  @test.given_an_invalid_configuration_service_token(arg1)
end

Given(/^no configuration service token$/) do
  @test.given_no_configuration_service_token
end

Given(/^the configuration service token is not appropriate for my configuration$/) do
  @test.given_the_configuration_service_token_is_not_appropriate_for_my_configuration
end

Given(/^a failure retrieving my configuration$/) do
  @test.given_a_failure_retrieving_my_configuration
end

Given(/^a valid configuration$/) do
  @test.given_valid_configuration
end

Given(/^an invalid configuration$/) do
  @test.given_invalid_configuration
end

Given(/^no configuration$/) do
  @test.given_no_configuration
end

Given(/^a valid authentication provider$/) do
  @test.given_a_valid_authentication_provider
end

Given(/^an invalid authentication provider$/) do
  @test.given_an_invalid_authentication_provider
end

Given(/^no authentication provider$/) do
  @test.given_no_authentication_provider
end

Given(/^a valid certificate authority trust chain$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^a valid certificate authority verification URI$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^an invalid certificate authority trust chain$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^a valid certificate revokation list URI$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^an invalid certificate authority verification URI$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^an valid certificate authority verification URI$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^a invalid certificate revokation list URI$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^no certificate authority trust chain$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^no certificate authority verification URI$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^no certificate revokation list URI$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I remember the configuration$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I notify 'invalid certificate authority trust chain'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I notify 'invalid certificate authority verification URI'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I notify 'invalid certificate revokation list URI'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I notify 'missing certificate authority trust chain'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I notify 'missing authority verification URI'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I notify 'missing certificate revokation list URI'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I remember the authentication provider$/) do
  expect(@test.has_remembered_authentication_provider).to eq(true)
end

Then(/^I notify 'invalid authentication provider'$/) do
  expect(@test.audit_entry_with_message_exist?('invalid authentication provider')).to eq(true)
end

Then(/^I notify 'Having no authentication is not recommended for production'$/) do
  expect(@test.audit_entry_with_message_exist?('Having no authentication is not recommended for production')).to eq(true)
end

Then(/^I remember my configuration$/) do
  expect(@test.has_remembered_my_configuration).to eq(true)
end

Then(/^I notify 'Invalid configuration'$/) do
  expect(@test.audit_entry_with_message_exist?('Invalid configuration')).to eq(true)
end

Then(/^I notify 'missing configuration'$/) do
  expect(@test.audit_entry_with_message_exist?('missing configuration')).to eq(true)
end

Then(/^I can extract the service identifier from the environment file$/) do
  expect(@test.can_extract_the_service_identifier_from_the_environment_file).to eq(true)
end

Then(/^I can extract the service registry URI from the environment file$/) do
  expect(@test.can_extract_the_service_registry_uri_from_the_environment_file).to eq(true)
end

Then(/^I can extract the authentication service URI from the environment file$/) do
  expect(@test.can_extract_the_authentication_service_uri_from_the_environment_file).to eq(true)
end

Then(/^I can extract the execution environment indicator from the environment file$/) do
  expect(@test.can_extract_the_execution_environment_indicator_from_the_environment_file).to eq(true)
end

Then(/^I can extract the configuration service URI from the environment file$/) do
  expect(@test.can_extract_the_configuration_service_uri_from_the_environment_file).to eq(true)
end

Then(/^I can extract the configuration service token from the environment file$/) do
  expect(@test.can_extract_the_configuration_service_token_from_the_environment_file).to eq(true)
end

Then(/^I can extract the configuration service provider from the environment file$/) do
  expect(@test.can_extract_the_configuration_service_provider_from_the_environment_file).to eq(true)
end

Then(/^I can extract the session key from the environment file$/) do
  expect(@test.can_extract_the_session_key_from_the_environment_file).to eq(true)
end

Then(/^I can extract the session secret from the environment file$/) do
  expect(@test.can_extract_the_session_secret_from_the_environment_file).to eq(true)
end

Then(/^I notify 'Failure retrieving environment from file'$/) do
  expect(@test.audit_entry_with_message_exist?('Failure retrieving environment from file')).to eq(true)
end

Then(/^I remember the execution environment indicator$/) do
  expect(@test.has_remembered_the_execution_environment_indicator).to eq(true)
end

Then(/^I notify 'Invalid execution environment indicator'$/) do
  expect(@test.audit_entry_with_message_exist?('Invalid execution environment indicator')).to eq(true)
end

Then(/^I notify 'Missing execution environment indicator'$/) do
  expect(@test.audit_entry_with_message_exist?('Missing execution environment indicator')).to eq(true)
end

Then(/^I remember the session configuration$/) do
  expect(@test.has_remembered_the_session_configuration).to eq(true)
end

Then(/^I can extract the service identifier from the environment$/) do
  expect(@test.can_extract_the_service_identifier_from_the_environment).to eq(true)
end

Then(/^I can extract the service registry URI from the environment$/) do
  expect(@test.can_extract_the_service_registry_uri_from_the_environment).to eq(true)
end

Then(/^I can extract the authentication service URI from the environment$/) do
  expect(@test.can_extract_the_authentication_service_uri_from_the_environment).to eq(true)
end

Then(/^I can extract the execution environment indicator from the environment$/) do
  expect(@test.can_extract_the_execution_environment_indicator_from_the_environment).to eq(true)
end

Then(/^I can extract the configuration service URI from the environment$/) do
  expect(@test.can_extract_the_configuration_service_uri_from_the_environment).to eq(true)
end

Then(/^I can extract the configuration service token from the environment$/) do
  expect(@test.can_extract_the_configuration_service_token_from_the_environment).to eq(true)
end

Then(/^I can extract the configuration service provider from the environment$/) do
  expect(@test.can_extract_the_configuration_service_provider_from_the_environment).to eq(true)
end

Then(/^I can extract the session key from the environment$/) do
  expect(@test.can_extract_the_session_key_from_the_environment).to eq(true)
end

Then(/^I can extract the session secret from the environment$/) do
  expect(@test.can_extract_the_session_secret_from_the_environment).to eq(true)
end

Then(/^I retrieve my configuration from the configuration service only$/) do
  expect(@test.has_retrieved_configuration_from_the_configuration_service_only).to eq(true)
end

Then(/^I retrieve my configuration from the file$/) do
  expect(@test.has_retrieved_configuration_from_the_file).to eq(true)
end

Then(/^I notify 'Invalid configuration file'$/) do
  expect(@test.audit_entry_with_message_exist?('Invalid configuration file')).to eq(true)
end

Then(/^I notify 'Failure retrieving configuration from file'$/) do
  expect(@test.audit_entry_with_message_exist?('Failure retrieving configuration from file')).to eq(true)
end

Then(/^I remember the service registry URI$/) do
  expect(@test.has_remembered_service_registry_uri).to eq(true)
end

Then(/^I notify 'invalid URI'$/) do
  expect(@test.audit_entry_with_message_exist?('invalid URI')).to eq(true)
end

Then(/^I notify 'Missing service registry URI'$/) do
  expect(@test.audit_entry_with_message_exist?('Missing service registry URI')).to eq(true)
end

Then(/^I retrieve my configuration$/) do
  expect(@test.has_retrieved_my_configuration).to eq(true)
end

Then(/^I notify 'invalid configuration service URI'$/) do
  expect(@test.audit_entry_with_message_exist?('invalid configuration service URI')).to eq(true)
end

Then(/^I notify 'missing configuration service URI'$/) do
  expect(@test.audit_entry_with_message_exist?('missing configuration service URI')).to eq(true)
end

Then(/^I notify 'invalid configuration service token'$/) do
  expect(@test.audit_entry_with_message_exist?('invalid configuration service token')).to eq(true)
end

Then(/^I notify 'missing configuration service token'$/) do
  expect(@test.audit_entry_with_message_exist?('missing configuration service token')).to eq(true)
end

Then(/^I notify 'incorrect configuration service token'$/) do
  expect(@test.audit_entry_with_message_exist?('incorrect configuration service token')).to eq(true)
end

Then(/^I notify 'failure retrieving configuration'$/) do
  expect(@test.audit_entry_with_message_exist?('failure retrieving configuration')).to eq(true)
end
