Given(/^an audit event$/) do
  @test.given_audit_message('Some audit event')
end

Given(/^no audit event$/) do
  @test.given_audit_message('')
end

Given(/^a message$/) do
  @test.given_audit_message('event message')
end



Given(/^a valid time$/) do
  @test.given_valid_time
end

Given(/^an invalid time$/) do
  @test.given_invalid_time
end


Given(/^no auditing level$/) do
  @test.given_auditing_level(nil)
end

Given(/^a valid auditing level$/) do
  @test.given_auditing_level(:debug)
end

Given(/^an invalid auditing level$/) do
  @test.given_auditing_level(:something)
end

Given(/^an auditing level 'debug'$/) do
  @test.given_auditing_level(:debug)
end

Given(/^an auditing level 'info'$/) do
  @test.given_auditing_level(:info)
end

Given(/^an auditing level 'warn'$/) do
  @test.given_auditing_level(:warn)
end

Given(/^an auditing level 'error'$/) do
  @test.given_auditing_level(:error)
end

Given(/^an auditing level 'fatal'$/) do
  @test.given_auditing_level(:fatal)
end

Given(/^an optional field$/) do
  @test.given_audit_message('[key:value] message with optional field')
end

Given(/^an empty optional field$/) do
  @test.given_audit_message('[key:] message with empty optional field')
end

Given(/^no optional field$/) do
  @test.given_audit_message('message with no optional field')
end

Given(/^an invalid optional field$/) do
  @test.given_audit_message('[[ message with invalid optional field')
end

Given(/^a flow identifier$/) do
  @test.given_flow_identifier
end




When(/^I am asked to audit$/) do
  @test.notify_audit
end





Then(/^I add the audit event to the buffer$/) do
  puts "nothing" # Write code here that turns the phrase above into concrete actions
  expect(true).to eq(false)
end

Then(/^I report the buffered audit event$/) do
  puts "nothing"
  expect(true).to eq(false)
   # Write code here that turns the phrase above into concrete actions
end

Then(/^I report the buffered audit event$/) do
  puts "nothing"
  expect(true).to eq(false)
   # Write code here that turns the phrase above into concrete actions
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
  expect(@test.is_correctly_formatted?).to eq(true)
end




Then(/^I notify 'Unknown auditing level'$/) do
  puts "nothing"
  expect(true).to eq(false)
   # Write code here that turns the phrase above into concrete actions
end



Then(/^I default to 'debug' level$/) do
  expect(@test.has_audited_with_level?(:debug)).to eq(true)
end

Then(/^I provide the 'debug' auditing level$/) do
  expect(@test.has_audited_with_level?(:debug)).to eq(true)
end

Then(/^I provide the 'info' auditing level$/) do
  expect(@test.has_audited_with_level?(:info)).to eq(true)
end

Then(/^I provide the 'warn' auditing level$/) do
  expect(@test.has_audited_with_level?(:warn)).to eq(true)
end

Then(/^I provide the 'error' auditing level$/) do
  expect(@test.has_audited_with_level?(:error)).to eq(true)
end

Then(/^I provide the 'fatal' auditing level$/) do
  expect(@test.has_audited_with_level?(:fatal)).to eq(true)
end

Then(/^I notify an auditing provider with no audit event$/) do
  expect(@test.has_notified_with_message?('')).to eq(true)
end

Then(/^I provide my identifier$/) do
  expect(@test.has_notified_with_my_identifier?).to eq(true)
end

Then(/^I provide the optional field$/) do
  @test.has_notified_with_message?('[key:value] message with optional field')
end

Then(/^I provide the empty optional field$/) do
  @test.has_notified_with_message?('[key:] message with empty optional field')
end

Then(/^I provide no optional field$/) do
  @test.has_notified_with_message?('message with no optional field')
end

Then(/^I treat the option field as normal message text$/) do
  @test.has_notified_with_message?('[[ message with invalid optional field')
end

Then(/^I provide the flow identifier$/) do
  @test.has_notified_with_flow_identifier?
end

Then(/^I provide the message$/) do
  @test.has_notified_with_message?('event message')
end
