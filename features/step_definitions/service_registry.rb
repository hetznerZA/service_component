
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

Given(/^a service name$/) do
  @test.given_a_service_name
end

Given(/^the service is registered in the service registry$/) do
  @test.given_the_service_is_registered_in_the_service_registry
end

Given(/^the service has access points registered in the service registry$/) do
  @test.given_the_service_has_access_points_registered_in_the_service_registry
end

Given(/^no access points for that service in the service registry$/) do
  @test.given_no_access_points_for_that_service_in_the_service_registry
end

Given(/^the service is not registered in the service registry$/) do
  @test.given_the_service_is_not_registered_in_the_service_registry
end

Given(/^I have cached the answer before$/) do
  @test.given_i_have_cached_the_answer_before
end

Given(/^a service registry failure$/) do
  @test.given_a_service_registry_failure
end

Given(/^I have not cached the answer before$/) do
  @test.given_i_have_not_cached_the_answer_before
end

Given(/^the service has multiple access points registered in the service registry$/) do
  @test.given_the_service_has_multiple_access_points_registered_in_the_service_registry
end

Given(/^some of the access points are unreachable$/) do
  @test.given_some_of_the_access_points_are_unreachable
end


When(/^determining authorization for the service$/) do
  @test.determine_authorization_for_the_service
end

When(/^I am asked to find service URIs for that service$/) do
  @test.find_service_uris_for_the_service
end

When(/^I am asked to find the best service URIs for that service$/) do
  @test.find_best_service_uris_for_the_service
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
  expect(@test.audit_entry_with_message_exist?('Service registry client failure')).to eq(true)
end

Then(/^I notify 'Could not find policy'$/) do
  expect(@test.audit_entry_with_message_exist?('Could not find policy')).to eq(true)
end

Then(/^I notify 'No policy associated with service'$/) do
  expect(@test.audit_entry_with_message_exist?('No policy associated with service')).to eq(true)
end

Then(/^I notify 'Could not retrieve policy for service'$/) do
  expect(@test.audit_entry_with_message_exist?('Could not retrieve policy for service')).to eq(true)
end

Then(/^I notify 'Failure to look up service in service registry'$/) do
  expect(@test.audit_entry_with_message_exist?('Failure to look up service in service registry')).to eq(true)
end

Then(/^I ask the service registry for access points for the service$/) do
  expect(@test.has_asked_the_service_registry_for_access_points_for_the_service).to eq(true)
end

Then(/^I cache the first service URIs in the list of access points$/) do
  expect(@test.has_cached_the_first_service_uris_in_in_the_list_of_acccess_points).to eq(true)
end

Then(/^I return the first service URIs in the list of access points the service registry returns$/) do
  expect(@test.has_returned_the_first_service_uris_in_the_list_of_access_points_the_service_registry_returns).to eq(true)
end

Then(/^I cache nil$/) do
  expect(@test.has_cached_nil).to eq(true)
end

Then(/^I return nil$/) do
  expect(@test.has_returned_nil).to eq(true)
end

Then(/^I do not cache nil$/) do
  expect(@test.has_not_cached_nil).to eq(true)
end

Then(/^I return the cached value$/) do
  expect(@test.has_returned_cached_value).to eq(true)
end

Then(/^I ask the services for their functional status$/) do
  expect(@test.has_asked_the_services_for_their_functional_status).to eq(true)
end

Then(/^I return the service URI for which the best functional status was obtained$/) do
  expect(@test.has_returned_the_service_uri_for_which_the_best_functional_status_was_obtained).to eq(true)
end

Then(/^I do not cache$/) do
  expect(@test.has_not_cached).to eq(true)
end

Then(/^I answer in no more than (\d+) seconds$/) do |arg1|
  expect(@test.has_answered_in_less_than(arg1)).to eq(true)
end

Then(/^I do not update the cache based on functional status$/) do
  expect(@test.has_not_updated_the_cache_based_on_functional_status).to eq(true)
end
