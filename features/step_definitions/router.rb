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
  @test.given_a_request_for_a_service_with_rest_parametrized_resource
end

Given(/^no controller matches the request directly$/) do
  @test.given_no_controller_matches_the_request_directly
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
  expect(@test.has_not_excluded_parametrized_resource_matching_in_the_design?).to eq(true)
end
