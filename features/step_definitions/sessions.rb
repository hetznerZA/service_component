Given(/^a session client$/) do
  @test.given_a_session_client
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

Given(/^no session key is present$/) do
  @test.given_no_session_key_is_present
end

Given(/^no session secret is present$/) do
  @test.given_no_session_secret_is_present
end

Given(/^session key is invalid$/) do
  @test.given_session_key_is_invalid
end

Given(/^session secret is invalid$/) do
  @test.given_session_secret_is_invalid
end

Given(/^a session secret$/) do
  @test.given_a_session_secret
end

Given(/^a unique session key$/) do
  @test.given_a_unique_session_key
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

Then(/^the session is encrypted using the secret$/) do
  expect(@test.the_session_is_encrypted_using_the_secret?).to eq(true)
end

Then(/^session interactions are persisted using the key$/) do
  expect(@test.session_interactions_are_persisted_using_the_key?).to eq(true)
end
