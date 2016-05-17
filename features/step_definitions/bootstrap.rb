Given(/^a valid service identifier$/) do
  @test.given_valid_service_identifier
end

Given(/^an environment configuration$/) do
  @test.given_environment_configuration
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
  expect(@test.has_received_notification?('invalid service identifier')).to eq(true)
end

Then(/^I do not complete bootstrap$/) do
  expect(@test.has_completed_bootstrap?).to eq(false)
end

Given(/^no service identifier$/) do
    @test.given_no_service_identifier
end