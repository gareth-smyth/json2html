require 'json2html/version'
require 'JSON'

# This class provides the interface to convert the Json to Html.  By default each of the object values in the json will
# be wrapped in a div with an id matching the object identifier.
#
# @example Convert a number
#   Json2Html.new.to_html("my_value":13.5) == '<div id="my_value">13.5</div>'
#
# @example Convert a string
#   Json2Html.new.to_html("my_value":"some text") == '<div id="my_value">some text</div>'
#
# @example Convert a null
#   Json2Html.new.to_html("my_value":null) == '<div id="my_value"></div>'
#
# @example Convert a true
#   Json2Html.new.to_html("my_value":true) == '<div id="my_value">true</div>'
#
# @example Convert a false
#   Json2Html.new.to_html("my_value":false) == '<div id="my_value">false</div>'
#
class Json2Html
  def to_html(json_string)
    hashed_string = JSON.parse(json_string)
    html_string = ''
    hashed_string.each do |key, value|
      html_string << key_value_to_html(key, value)
    end
    html_string
  end

  private

  def key_value_to_html(key, value)
    if value.is_a?(Array)
      array_html = "<ul id=\"#{key}\">"
      value.each_with_index do |array_item, index|
        array_html << '<li>' << key_value_to_html("#{key}_#{index + 1}", array_item) << '</li>'
      end
      array_html << '</ul>'
    else
      "<div id=\"#{key}\">#{value}</div>"
    end
  end
end
