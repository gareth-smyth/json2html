Given(/^I create a new converter$/) do
  Json2HtmlBuilder.create_builder
end

And(/^I pass JSON data of (.*)$/) do |json_data|
  Json2HtmlBuilder.pass_data(json_data)
end

Then(/^it should return HTML with '(.*)'(?: (\d) times)?$/) do |value, times|
  times ||= 1
  expect Json2HtmlBuilder.values?(value, times)
end
