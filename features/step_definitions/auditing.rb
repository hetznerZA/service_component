Given(/^an audit event$/) do
  @test.given_audit_message('Some audit event')
end

Given(/^no audit event$/) do
  @test.given_audit_message('')
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
   # Write code here that turns the phrase above into concrete actions
end

Then(/^I provide my identifier$/) do
  puts "nothing"
  expect(true).to eq(false)
   # Write code here that turns the phrase above into concrete actions
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
