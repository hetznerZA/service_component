TEST_MESSAGE    = 'Something' unless defined? TEST_MESSAGE;    TEST_MESSAGE.freeze
NO_TEST_MESSAGE = ''          unless defined? NO_TEST_MESSAGE; NO_TEST_MESSAGE.freeze
DEBUG_LEVEL     = 'debug'     unless defined? DEBUG_LEVEL;     DEBUG_LEVEL.freeze
INFO_LEVEL      = 'info'      unless defined? INFO_LEVEL;      INFO_LEVEL.freeze
WARN_LEVEL      = 'warn'      unless defined? WARN_LEVEL;      WARN_LEVEL.freeze
ERROR_LEVEL     = 'error'     unless defined? ERROR_LEVEL;     ERROR_LEVEL.freeze
FATAL_LEVEL     = 'fatal'     unless defined? FATAL_LEVEL;     FATAL_LEVEL.freeze
MESSAGE_WITH_OPTIONAL_FIELD         = '[key:value] message with optional field'  unless defined? MESSAGE_WITH_OPTIONAL_FIELD;         MESSAGE_WITH_OPTIONAL_FIELD.freeze
MESSAGE_WITH_EMPTY_OPTIONAL_FIELD   = '[key:] message with empty optional field' unless defined? MESSAGE_WITH_EMPTY_OPTIONAL_FIELD;   MESSAGE_WITH_EMPTY_OPTIONAL_FIELD.freeze
MESSAGE_WITH_NO_OPTIONAL_FIELD      = 'message with no optional field'           unless defined? MESSAGE_WITH_NO_OPTIONAL_FIELD;      MESSAGE_WITH_NO_OPTIONAL_FIELD.freeze
MESSAGE_WITH_INVALID_OPTIONAL_FIELD = '[[ message with invalid optional field'   unless defined? MESSAGE_WITH_INVALID_OPTIONAL_FIELD; MESSAGE_WITH_INVALID_OPTIONAL_FIELD.freeze

Given(/^an audit event$/) do
  @test.given_audit_message(TEST_MESSAGE)
end

Given(/^no audit event$/) do
  @test.given_audit_message(NO_TEST_MESSAGE)
end

Given(/^a message$/) do
  @test.given_audit_message(TEST_MESSAGE)
end

Given(/^no auditing level$/) do
  @test.given_no_auditing_level
end

Given(/^a valid auditing level$/) do
  @test.given_auditing_level(DEBUG_LEVEL)
end

Given(/^an invalid auditing level$/) do
  puts "Invalid audit levels are not testable at the moment, defaulting to debug"
  @test.given_auditing_level(DEBUG_LEVEL)
end

Given(/^an auditing level 'debug'$/) do
  @test.given_auditing_level(DEBUG_LEVEL)
end

Given(/^an auditing level 'info'$/) do
  @test.given_auditing_level(INFO_LEVEL)
end

Given(/^an auditing level 'warn'$/) do
  @test.given_auditing_level(WARN_LEVEL)
end

Given(/^an auditing level 'error'$/) do
  @test.given_auditing_level(ERROR_LEVEL)
end

Given(/^an auditing level 'fatal'$/) do
  @test.given_auditing_level(FATAL_LEVEL)
end

Given(/^an optional field$/) do
  @test.given_audit_message(MESSAGE_WITH_OPTIONAL_FIELD)
end

Given(/^an empty optional field$/) do
  @test.given_audit_message(MESSAGE_WITH_EMPTY_OPTIONAL_FIELD)
end

Given(/^no optional field$/) do
  @test.given_audit_message(MESSAGE_WITH_NO_OPTIONAL_FIELD)
end

Given(/^an invalid optional field$/) do
  @test.given_audit_message(MESSAGE_WITH_INVALID_OPTIONAL_FIELD)
end

Given(/^a flow identifier$/) do
  @test.given_flow_identifier
end

Given(/^the request has no flow identifier$/) do
  @test.given_request_without_flow_identifier
end

Given(/^the request has a flow identifier$/) do
  @test.given_request_with_flow_identifier
end

Given(/^the audit buffer is full$/) do
  @test.given_the_audit_buffer_is_full
end

Given(/^an empty buffer$/) do
  @test.given_the_audit_buffer_is_empty
end

Given(/^a buffer with audit events$/) do
  @test.given_the_audit_buffer_contains_events
end

Given(/^a valid auditing provider$/) do
  @test.given_valid_auditing_provider
end

Given(/^an invalid auditing provider$/) do
  @test.given_invalid_auditing_provider
end

Given(/^an auditing provider initialization failure$/) do
  @test.given_auditing_provider_initialization_failure
end

Given(/^a valid auditor$/) do
  @test.given_valid_auditor
end

Given(/^an auditor initialization failure$/) do
  @test.given_auditor_initialization_failure
end

Given(/^an invalid auditor$/) do
  @test.given_invalid_auditor
end

Given(/^a valid auditor configuration$/) do
  @test.given_valid_auditor
end

Given(/^an invalid auditor configuration$/) do
  @test.given_invalid_auditor_configuration
end

Given(/^no auditor configuration$/) do
  @test.given_no_auditor_configuation
end

Given(/^a valid auditing provider configuration$/) do
  @test.given_valid_auditing_provider_configuration
end

Given(/^an invalid auditing provider configuration$/) do
  @test.given_invalid_auditing_provider_configuration
end

Given(/^no auditing provider configuration$/) do
  @test.given_no_auditing_provider_configuration
end

Given(/^a valid configured auditing level$/) do
  @test.given_valid_configured_auditing_level
end

Given(/^an invalid configured auditing level$/) do
  @test.given_invalid_configured_auditing_level
end

Given(/^no configured auditing level$/) do
  @test.given_no_configured_auditing_level
end

When(/^I am asked to audit$/) do
  @test.notify_audit
end

When(/^the service component receives a request$/) do
  @test.receive_a_request
end

When(/^the service component need to talk to another service$/) do
  @test.forward_request_to_another_service
end

When(/^I can report to the auditor$/) do
  @test.can_report_to_auditor
end

When(/^I cannot report to the auditor$/) do
  @test.cannot_report_to_auditor
end

When(/^I cannot report to any auditor$/) do
  @test.cannot_report_to_any_auditor
end

When(/^a shutdown is initiated$/) do
  @test.attempt_graceful_shutdown
end


Then(/^it should generate a unique flow identifier$/) do
  expect(@test.has_notified_with_new_flow_identifier?).to eq(true)
end

Then(/^update the request with the flow identifier$/) do
  expect(@test.has_notified_with_new_flow_identifier?).to eq(true)
end

Then(/^I want to use the flow identifier in auditing$/) do
  expect(@test.has_notified_with_flow_identifier?).to eq(true)
end

Then(/^I want to use the flow identifier to identify the flow in the new request$/) do
  expect(@test.has_notified_with_flow_identifier_in_new_request?).to eq(true)
end

Then(/^I add the audit event to the buffer$/) do
  expect(@test.has_been_notified?).to eq(true)
end

Then(/^I do not add the audit event to the buffer$/) do
  expect(@test.has_not_been_notified?).to eq(true)
end

Then(/^I notify 'Unknown auditing level'$/) do
  puts "Not testable at the moment"
end

Then(/^I notify an auditing provider of the audit event$/) do
  expect(@test.has_been_notified?).to eq(true)
end

Then(/^I provide the time$/) do
  expect(@test.has_notified_with_timestamp?).to eq(true)
end

Then(/^I provide the time as utc time$/) do
  expect(@test.has_notified_with_utc_timestamp?).to eq(true)
end

Then(/^the time I provide is in utc time$/) do
  expect(@test.has_notified_with_utc_timestamp?).to eq(true)
end

Then(/^the audit event is correctly formatted$/) do
  regular_expression = /(debug|info|warn|error|fatal),[a-zA-Z\d_.-]*,[a-f\d]{64},[\d]{4}-[\d]{2}-[\d]{2}T[\d]{2}:[\d]{2}:[\d]{2}.[\d]{3}Z,.*/
  expect(@test.is_correctly_formatted_as?(regular_expression)).to eq(true)
end

Then(/^I default to 'debug' level$/) do
  expect(@test.has_audited_with_level?(DEBUG_LEVEL)).to eq(true)
end

Then(/^I provide the 'debug' auditing level$/) do
  expect(@test.has_audited_with_level?(DEBUG_LEVEL)).to eq(true)
end

Then(/^I provide the 'info' auditing level$/) do
  expect(@test.has_audited_with_level?(INFO_LEVEL)).to eq(true)
end

Then(/^I provide the 'warn' auditing level$/) do
  expect(@test.has_audited_with_level?(WARN_LEVEL)).to eq(true)
end

Then(/^I provide the 'error' auditing level$/) do
  expect(@test.has_audited_with_level?(ERROR_LEVEL)).to eq(true)
end

Then(/^I provide the 'fatal' auditing level$/) do
  expect(@test.has_audited_with_level?(FATAL_LEVEL)).to eq(true)
end

Then(/^I notify an auditing provider with no audit event$/) do
  expect(@test.has_notified_with_message?(NO_TEST_MESSAGE)).to eq(true)
end

Then(/^I provide my identifier$/) do
  expect(@test.has_notified_with_my_identifier?).to eq(true)
end

Then(/^I provide the optional field$/) do
  expect(@test.has_notified_with_message?(MESSAGE_WITH_OPTIONAL_FIELD)).to eq(true)
end

Then(/^I provide the empty optional field$/) do
  expect(@test.has_notified_with_message?(MESSAGE_WITH_EMPTY_OPTIONAL_FIELD)).to eq(true)
end

Then(/^I provide no optional field$/) do
  expect(@test.has_notified_with_message?(MESSAGE_WITH_NO_OPTIONAL_FIELD)).to eq(true)
end

Then(/^I treat the option field as normal message text$/) do
  expect(@test.has_notified_with_message?(MESSAGE_WITH_INVALID_OPTIONAL_FIELD)).to eq(true)
end

Then(/^I provide the flow identifier$/) do
  expect(@test.has_notified_with_flow_identifier?).to eq(true)
end

Then(/^I provide the message$/) do
  expect(@test.has_notified_with_message?(TEST_MESSAGE)).to eq(true)
end

Then(/^I remove the oldest audit event from the buffer$/) do
  expect(@test.has_removed_the_oldest_event_from_the_buffer?).to eq(true)
end

Then(/^I do not report to auditor$/) do
  expect(@test.did_not_report_anything?).to eq(true)
end

Then(/^I report the oldest audit event from the buffer$/) do
  expect(@test.reported_oldest_event_in_buffer?).to eq(true)
end

Then(/^I do not remove the oldest audit event from the buffer$/) do
  expect(@test.reported_oldest_event_in_buffer?).to eq(false)
end

Then(/^I have an initialized auditing provider$/) do
  expect(@test.have_initialized_auditing_provider?).to eq(true)
end

Then(/^I notify 'Failure initializing auditing provider'$/) do
  expect(@test.has_received_notification?('Failure initializing auditing provider')).to eq(true)
end

Then(/^I have an initialized auditor$/) do
  expect(@test.have_initialized_auditor?).to eq(true)
end

Then(/^I notify 'Failure initializing auditor'$/) do
  expect(@test.has_received_notification?('Failure initializing auditor')).to eq(true)
end

Then(/^I remember the auditing provider configuration$/) do
  expect(@test.has_remembered_auditing_provider_configuration?).to eq(true)
end

Then(/^I notify 'Invalid auditing provider configuration'$/) do
  expect(@test.has_received_notification?('Invalid auditing provider configuration')).to eq(true)
end

Then(/^I notify 'Missing auditing provider configuration'$/) do
  expect(@test.has_received_notification_for_missing_auditing_configuration?).to eq(true)
end

Then(/^I remember the auditing level$/) do
  expect(@test.has_remembered_auditing_level?).to eq(true)
end

Then(/^I remember the auditor configuration$/) do
  expect(@test.has_remembered_auditor_configuration?).to eq(true)
end

Then(/^I notify 'Invalid auditing level'$/) do
  expect(@test.has_received_notification?('Invalid auditing level')).to eq(true)
end

Then(/^I notify 'Missing auditing level'$/) do
  expect(@test.has_received_notification?('Missing auditing level')).to eq(true)
end

Then(/^I notify 'Invalid auditor configuration'$/) do
  expect(@test.has_received_notification?('Invalid auditor configuration')).to eq(true)
end

Then(/^I notify 'Missing auditor configuration'$/) do
  expect(@test.has_received_notification_for_missing_auditor_configuration?).to eq(true)
end

Then(/^I notify 'flushing to stderr'$/) do
  expect(@test.has_received_notification?('flushing to stderr')).to eq(true)
end

Then(/^I report the buffer to the auditor$/) do
  expect(@test.has_reported_the_buffer_to_the_auditor?).to eq(true)
end

Then(/^I report the buffer to standard error stream$/) do
  expect(@test.has_reported_the_buffer_to_standard_error_stream?).to eq(true)
end

Then(/^I do not complete bootstrap due to missing auditing configuration$/) do
  expect(@test.did_not_complete_bootstrap_due_to_missing_auditing_configuration?).to eq(true)
end
