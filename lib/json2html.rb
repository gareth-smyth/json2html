require 'json2html/version'
require 'json'

# This class provides the interface to convert the Json to Html.  By default each of the object values in the json will
# be wrapped in a div with an id matching the object identifier.
#
# @example Convert a number
#   Json2Html.new.to_html("my_value":13.5) == '<div id="my_value_label">My Value</div><div id="my_value">13.5</div>'
#
# @example Convert a string
#   Json2Html.new.to_html("my_value":"some text") == '<div id="my_value_label">My Value</div>
#                                                     <div id="my_value">some text</div>'
#
# @example Convert a null
#   Json2Html.new.to_html("my_value":null) == '<div id="my_value_label">My Value</div><div id="my_value"></div>'
#
# @example Convert a true
#   Json2Html.new.to_html("my_value":true) == '<div id="my_value_label">My Value</div><div id="my_value">true</div>'
#
# @example Convert a false
#   Json2Html.new.to_html("my_value":false) == '<div id="my_value_label">My Value</div><div id="my_value">false</div>'
#
# @example Convert an array
#   Json2Html.new.to_html("my_value":[5,6]) == '<div id="my_value_label">My Value</div>
#                                               <ul id="my_value">
#                                                 <li>
#                                                   <div id="my_value_1">5</div>
#                                                 </li>
#                                                 <li>
#                                                   <div id="my_value_2">6</div>
#                                                 </li>
#                                               </ul>'
#
# @example Convert an object
#   Json2Html.new.to_html("my_value":{"child1":"a", "child2":"b"}} == '<div id="my_value_label">My Value</div>
#                                                                      <div id="my_value">
#                                                                       <div id="my_value_child1">a</div>
#                                                                       <div id="my_value_child2">b</div>
#                                                                      </div>'
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
      array_to_html(key, value)
    elsif value.is_a?(Hash)
      hash_to_html(key, value)
    else
      label = humanise(key)
      "<div id=\"#{key}_label\">#{label}</div><div id=\"#{key}\">#{value}</div>"
    end
  end

  def hash_to_html(hash_name, hash)
    label = humanise(hash_name)
    html_string = "<div id=\"#{hash_name}_label\">#{label}</div><div id=\"#{hash_name}\">"
    hash.each do |key, value|
      html_string << key_value_to_html("#{hash_name}_#{key}", value)
    end
    html_string << '</div>'
  end

  def array_to_html(array_key, array_value)
    array_html = "<ul id=\"#{array_key}\">"
    array_value.each_with_index do |array_item, index|
      array_html << '<li>' << key_value_to_html("#{array_key}_#{index + 1}", array_item) << '</li>'
    end
    array_html << '</ul>'
  end

  def humanise(string)
    string.split('_').map(&:capitalize).join(' ')
  end
end
