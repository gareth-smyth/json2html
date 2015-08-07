require 'json2html/version'
require 'json2html_config_dsl'
require 'json'

# This class provides the interface to convert the Json to Html.  By default each of the object values in the json will
# be wrapped in a div with an id matching the object identifier.
#
# See README.md for examples
#
class Json2Html
  def initialize(&block)
    @config = Json2HtmlConfig.new(&block)
  end

  def to_html(json_string)
    hashed_string = JSON.parse(json_string)
    html_string = ''
    hashed_string.each do |key, value|
      html_string << key_value_to_html(key, value, key)
    end
    html_string
  end

  private

  def key_value_to_html(full_key, node_value, node_name, parent_is_array = false)
    if node_value.is_a?(Array)
      array_to_html(full_key, node_value, node_name)
    elsif node_value.is_a?(Hash)
      hash_to_html(full_key, node_value, node_name, parent_is_array)
    else
      @config.get_node(full_key, node_value, node_name)
    end
  end

  def hash_to_html(full_key, object, node_name, parent_is_array)
    html_string = ''
    html_string = @config.get_object_head(full_key, object, node_name) unless
        parent_is_array && @config.collapse_array_item_objects
    object.each do |child_node_name, node_value|
      html_string << key_value_to_html("#{full_key}_#{child_node_name}", node_value, child_node_name)
    end
    html_string << @config.get_object_footer(full_key, object, node_name) unless
        parent_is_array && @config.collapse_array_item_objects
    html_string
  end

  def array_to_html(full_key, array, array_name)
    array_html = @config.get_array_head(full_key, array, array_name)
    array.each_with_index do |array_item, index|
      array_html << @config.get_array_item_head(full_key, array, array_name, array_item, index)
      array_html << key_value_to_html("#{full_key}_#{index + 1}", array_item, "#{index + 1}", true)
      array_html << @config.get_array_item_footer(full_key, array, array_name, array_item, index)
    end
    array_html << @config.get_array_footer(full_key, array, array_name)
  end
end
