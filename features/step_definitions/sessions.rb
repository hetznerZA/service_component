Given(/^a session client$/) do
  @test.given_a_session_client
end

Given(/^a session$/) do
  @test.given_a_session
end

Given(/^an invalid session$/) do
  @test.given_a_invalid_session
end

Given(/^sessions use is undefined$/) do
  @test.given_sessions_use_is_undefined
end

Given(/^sessions use is invalid$/) do
  @test.given_sessions_use_is_invalid
end

Given(/^sessions are not used$/) do
  @test.given_sessions_are_not_used
end

Given(/^sessions are used$/) do
  @test.given_sessions_are_used
end

Given(/^no session key$/) do
  @test.given_no_session_key
end

Given(/^no session secret$/) do
  @test.given_no_session_secret
end

Given(/^an invalid session key$/) do
  @test.given_session_key_is_invalid
end

Given(/^an invalid session secret$/) do
  @test.given_session_secret_is_invalid
end

Given(/^a valid session secret$/) do
  @test.given_a_session_secret_in_environment_file
end

Given(/^a valid session key$/) do
  @test.given_a_valid_session_key_in_environment_file
end

Then(/^this service component must not be less compliant to RFC 6265 than https:\/\/github\.com\/rack$/) do
  expect(@test.this_service_component_must_not_be_less_compliant_than_rack?).to eq(true)
end

Then(/^I notify 'Undefined USE_SESSIONS value'$/) do
  expect(@test.has_received_notification?('Undefined USE_SESSIONS value')).to eq(true)
end

Then(/^I notify 'Invalid USE_SESSIONS value'$/) do
  expect(@test.has_received_notification?('Invalid USE_SESSIONS value')).to eq(true)
end

Then(/^I notify 'Not using sessions'$/) do
  expect(@test.has_received_notification?('Not using sessions')).to eq(true)
end

Then(/^a session is not used when servicing the request$/) do
  expect(@test.a_session_is_not_used_when_servicing_the_request?).to eq(true)
end

Then(/^I notify 'Missing session key'$/) do
  expect(@test.has_received_notification?('Missing session key')).to eq(true)
end

Then(/^I notify 'Missing session secret'$/) do
  expect(@test.has_received_notification?('Missing session secret')).to eq(true)
end

Then(/^I notify 'Invalid session key'$/) do
  expect(@test.has_received_notification?('Invalid session key')).to eq(true)
end

Then(/^I notify 'Invalid session secret'$/) do
  expect(@test.has_received_notification?('Invalid session secret')).to eq(true)
end

Then(/^the service component enables verification of the session integrity$/) do
  expect(@test.service_component_enables_verification_of_the_session_integrity?).to eq(true)
end

Then(/^session integrity is verified/) do
  expect(@test.the_session_integrity_is_verified?).to eq(true)
end

Then(/^session integrity verification fails$/) do
  expect(@test.the_session_integrity_is_verified?).to eq(false)
end

Then(/^session interactions are persisted using the key$/) do
  expect(@test.session_interactions_are_persisted_using_the_key?).to eq(true)
end
