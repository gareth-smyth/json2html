$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'json2html'
require 'json2html_config_dsl'
require 'nokogiri'

module HtmlHelper
  def parse(html)
    Nokogiri::HTML.parse(html)do |config|
      config.strict
    end
  end
end
