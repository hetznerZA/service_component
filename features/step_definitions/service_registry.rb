
Given(/^a valid service registry URI$/) do
  @test.given_a_valid_service_registry_uri
end

Given(/^a service registry client provider$/) do
  @test.given_a_service_registry_client_provider
end

Given(/^no service registry client provider$/) do
  @test.given_no_service_registry_client_provider
end

Given(/^a service registry client initialization failure$/) do
  @test.given_a_service_registry_client_initialization_failure
end

Given(/^a request for a service$/) do
  @test.given_a_request_for_a_service
end

Given(/^a policy for the service exists$/) do
  @test.given_a_policy_for_the_service_exists
end

Given(/^the policy is registered with the service$/) do
  @test.given_the_policy_is_registered_with_the_service
end

Given(/^a policy for the service does not exists$/) do
  @test.given_a_policy_for_the_service_does_not_exists
end

Given(/^the policy is not registered with the service$/) do
  @test.given_the_policy_is_not_registered_with_the_service
end

Given(/^a failure$/) do
  @test.given_a_failure
end


When(/^determining authorization for the service$/) do
  @test.determine_authorization_for_the_service
end


Then(/^I have an initialized service registry client$/) do
  expect(@test.has_an_initialized_service_registry_client).to eq(true)
end

Then(/^the client has the full suite of service registry functionality$/) do
  expect(@test.the_client_has_the_full_suite_of_service_registry_functionality).to eq(true)
end

Then(/^I ask the service registry for the service policy name$/) do
  expect(@test.has_asked_the_service_registry_for_the_service_policy_name).to eq(true)
end

Then(/^I notify 'Missing service registry client'$/) do
  puts "Unable to test this at present"
  #expect(@test.has_received_notification?('Missing service registry client')).to eq(true)
end

Then(/^I notify 'Service registry client failure'$/) do
  expect(@test.has_received_notification?('Service registry client failure')).to eq(true)
end

Then(/^I notify 'Could not find policy'$/) do
  expect(@test.has_received_notification?('Could not find policy')).to eq(true)
end

Then(/^I notify 'No policy associated with service'$/) do
  expect(@test.has_received_notification?('No policy associated with service')).to eq(true)
end

Then(/^I notify 'Could not retrieve policy for service'$/) do
  expect(@test.has_received_notification?('Could not retrieve policy for service')).to eq(true)
end
