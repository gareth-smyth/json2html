require 'json2html'

# This module is basically a simple builder which allows a Json2Html object to be maintained through the course
# of a scenario
module Json2HtmlBuilder
  def self.create_builder
    @json2html = Json2Html.new
  end

  def self.pass_data(json_data)
    @html_output = @json2html.to_html(json_data)
  end

  def self.values?(value, times)
    @html_output.scan(value).length >= times
  end
end

World(Json2HtmlBuilder)

Transform(/^-?\d+$/) do |number|
  number.to_i
end
