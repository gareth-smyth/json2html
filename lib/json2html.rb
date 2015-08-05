require 'json2html/version'
require 'JSON'

# This class provides the interface to convert the Json to Html.  By default each of the object values in the json will
# be wrapped in a div with an id matching the object identifier.
#
# @example Convert a number
#   Json2Html.new.to_html("my_number":13.5) == '<div id="my_number">13.5</div>'
#
# @example Convert a string
#   Json2Html.new.to_html("my_string":"some text") == '<div id="my_string">some text</div>'
#
# @example Convert a null
#   Json2Html.new.to_html("my_null":null) == '<div id="my_null"></div>'
#
class Json2Html
  def to_html(json_string)
    hashed_string = JSON.parse(json_string)
    html_string = ''
    hashed_string.each do |key, value|
      html_string << "<div id=\"#{key}\">#{value}</div>"
    end
    html_string
  end
end
