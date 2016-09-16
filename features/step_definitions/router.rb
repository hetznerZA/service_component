Given(/^a request for a service that match multiple controllers$/) do
  @test.given_a_request_for_a_service_that_match_multiple_controllers
end

Given(/^a request for a service that matches one controller$/) do
  @test.given_a_request_for_a_service_that_matches_one_controller
end

Given(/^a request for a service that matches no controller$/) do
  @test.given_a_request_for_a_service_that_matches_no_controller
end

Given(/^a request for a service with REST parametrized resource$/) do
  puts "Have to still implement exclude parametrized resource matching in strict path matching yet.  Waiting for the need."
  pending
  #@test.given_a_request_for_a_service_with_rest_parametrized_resource
end

Given(/^no controller matches the request directly$/) do
  @test.given_no_controller_matches_the_request_directly
end

Given(/^valid request parameters$/) do
  @test.given_request_with_valid_parameters
end

Given(/^invalid request parameters$/) do
  @test.given_request_with_invalid_parameters
end

Given(/^a routing that does not specify parameters$/) do
  @test.given_a_routing_that_does_not_specify_parameters
end

Given(/^a routing that specify non\-required parameters$/) do
  @test.given_a_routing_that_specify_nonrequired_parameters
end

Given(/^a routing that specify required parameters$/) do
  @test.given_a_routing_that_specify_required_parameters
end

When(/^I receive a request$/) do
  @test.receive_a_request
end

Then(/^I match the path to registered controllers$/) do
  expect(@test.has_matched_the_path_to_registered_controllers?).to eq(true)
end

Then(/^I call the controller that match best$/) do
  expect(@test.has_called_the_controller_that_match_best?).to eq(true)
end

Then(/^I match the path to the controller$/) do
  expect(@test.has_matched_the_path_to_the_controller?).to eq(true)
end

Then(/^I call the controller$/) do
  expect(@test.has_called_the_controller?).to eq(true)
end

Then(/^I attempt to match the path to registered controllers$/) do
  expect(@test.has_attempted_to_matched_the_path_to_registered_controllers?).to eq(true)
end

Then(/^I do not call a controller$/) do
  expect(@test.has_not_called_a_controller?).to eq(true)
end

Then(/^I notify 'no match'$/) do
  expect(@test.audit_entry_with_message_exist?('no match')).to eq(true)
end

Then(/^I do not exclude parametrized resource matching in the design$/) do
  puts "Have to still implement exclude parametrized resource matching in strict path matching yet.  Waiting for the need."
  pending
  #expect(@test.has_not_excluded_parametrized_resource_matching_in_the_design?).to eq(true)
end

Then(/^I allow the request to be routed to the controller$/) do
  expect(@test.request_was_allowed_to_be_routed_to_controller?).to eq(true)
end

Then(/^I reject the request due to invalid request parameters$/) do
  expect(@test.request_was_rejected_due_to_invalid_request_parameters?).to eq(true)
end
