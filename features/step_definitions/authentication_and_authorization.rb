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

Given(/^an execution environment 'development'$/) do
  @test.given_an_development_execution_environment
end

Given(/^a request requiring authentication$/) do
  @test.given_a_request_requiring_authentication
end

Given(/^an authenticaton provider initialization failure$/) do
  @test.given_an_authenticaton_provider_initialization_failure
end

When(/^I am asked whether the request has authenticated$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I am asked who has authenticated$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I am asked who delegated the authentication$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I am asked whether the request has been delegated$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I respond true$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I respond with the authenticated human identity's identifier$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I respond with the authenticated service identity's identifier$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I respond with nil$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I respond with the authenticated identity's identifier$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I notify 'Failure determining authentication identity'$/) do
  expect(@test.audit_entry_with_message_exist?('Failure determining authentication identity')).to eq(true)
end

Then(/^I respond false$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I respond with the identity of the originator$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I notify 'Could not determine delegation'$/) do
  expect(@test.audit_entry_with_message_exist?('Could not determine delegation')).to eq(true)
end

Then(/^I respond with 'developer'$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I have an initialized authentication provider$/) do
  expect(@test.have_an_initialized_authentication_provider?).to eq(true)
end

Then(/^I notify 'Failure initializing authentication provider'$/) do
  expect(@test.audit_entry_with_message_exist?('Failure initializing authentication provider')).to eq(true)
end
