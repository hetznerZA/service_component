Given(/^an authenticated identity$/) do
  @test.given_an_authenticated_identity
end

Given(/^a request that requires authentication$/) do
  @test.given_a_request_that_requires_authentication
end

Given(/^an authenticated human identity$/) do
  @test.given_an_authenticated_human_identity
end

Given(/^an authenticated service identity$/) do
  @test.given_an_authenticated_service_identity
end

Given(/^no authenticated identity$/) do
  @test.given_no_authenticated_identity
end

Given(/^a request that does not require authentication$/) do
  @test.given_a_request_that_does_not_require_authentication
end

Given(/^an authentication failure$/) do
  @test.given_an_authentication_failure
end

Given(/^an originator of authentication delegation$/) do
  @test.given_an_originator_of_authentication_delegation
end

Given(/^a delegated request$/) do
  @test.given_a_delegated_request
end

Given(/^no originator of authentication delegation$/) do
  @test.given_no_originator_of_authentication_delegation
end

Given(/^a request requiring authentication$/) do
  @test.given_a_request_requiring_authentication
end

Given(/^an authenticaton provider initialization failure$/) do
  @test.given_an_authenticaton_provider_initialization_failure
end

Given(/^a valid authorization provider$/) do
  @test.given_a_valid_authorization_provider
end

Given(/^an authorization provider initialization failure$/) do
  @test.given_an_authorization_provider_initialization_failure
end

Given(/^an authorization policy that approves$/) do
  @test.given_an_authorization_policy_that_approves
end

Given(/^an authorization policy that does not approve$/) do
  @test.given_an_authorization_policy_that_does_not_approve
end

Given(/^no authorization policy$/) do
  @test.given_no_authorization_policy
end

Given(/^an authorization policy$/) do
  @test.given_an_authorization_policy
end

Given(/^an authorization failure$/) do
  @test.given_an_authorization_failure
end

When(/^I am asked whether the request has authenticated$/) do
  @test.when_asked_whether_the_request_has_authenticated
end

When(/^I am asked who has authenticated$/) do
  @test.when_asked_who_has_authenticated
end

When(/^I am asked who delegated the authentication$/) do
  @test.when_asked_who_delegated_the_authentication
end

When(/^I am asked whether the request has been delegated$/) do
  @test.when_asked_whether_the_request_has_been_delegated
end

When(/^asked to authorize the service$/) do
  @test.authorize_the_service
end

Then(/^I apply the policy$/) do
  expect(@test.have_applied_the_policy?).to eq(true)
end

Then(/^I do not apply a policy$/) do
  expect(@test.have_not_applied_the_policy?).to eq(true)
end

Then(/^I respond with 'allow'$/) do
  expect(@test.have_responded_with_allow?).to eq(true)
end

Then(/^I respond with 'deny'$/) do
  expect(@test.have_responded_with_deny?).to eq(true)
end

Then(/^I notify 'Authorization failure'$/) do
  expect(@test.have_notified_authorization_failure?).to eq(true)
end

Then(/^I have an initialized authorization provider$/) do
  expect(@test.have_an_initialized_authorization_provider?).to eq(true)
end

Then(/^I notify 'Failure initializing authorization provider'$/) do
  puts "Unable to test this in soar sc"
end

Then(/^I respond true$/) do
  expect(@test.have_responded_with_true?).to eq(true)
end

Then(/^I respond with the authenticated human identity's identifier$/) do
  expect(@test.have_responded_with_the_authenticated_human_identity_identifier?).to eq(true)
end

Then(/^I respond with the authenticated service identity's identifier$/) do
  expect(@test.have_responded_with_the_authenticated_service_identity_identifier?).to eq(true)
end

Then(/^I respond with nil$/) do
  expect(@test.have_responded_with_nil?).to eq(true)
end

Then(/^I respond with no authenticated identity$/) do
  expect(@test.have_responded_with_no_authenticated_identity?).to eq(true)
end

Then(/^I respond with the authenticated identity's identifier in request not requiring authentication$/) do
  expect(@test.have_responded_with_the_authenticated_identity_identifier_in_request_not_requiring_authentication?).to eq(true)
end

Then(/^I respond with the authenticated identity's identifier$/) do
  expect(@test.have_responded_with_with_the_authenticated_identity_identifier?).to eq(true)
end

Then(/^I notify 'Failure determining authentication identity'$/) do
  expect(@test.have_notified_of_a_failure_determining_authentication_identity?).to eq(true)
end

Then(/^I respond false$/) do
  expect(@test.have_responded_with_false?).to eq(true)
end

Then(/^I respond with the identity of the originator$/) do
  expect(@test.have_responded_with_the_identity_of_the_originator?).to eq(true)
end

Then(/^I notify 'Could not determine delegation'$/) do
  expect(@test.audit_entry_with_message_exist?('Could not determine delegation')).to eq(true)
end

Then(/^I respond with 'developer'$/) do
  expect(@test.have_responded_with_developer?).to eq(true)
end

Then(/^I have an initialized authentication provider$/) do
  expect(@test.have_an_initialized_authentication_provider?).to eq(true)
end

Then(/^I notify 'Failure initializing authentication provider'$/) do
  expect(@test.audit_entry_with_message_exist?('Failure initializing authentication provider')).to eq(true)
end
