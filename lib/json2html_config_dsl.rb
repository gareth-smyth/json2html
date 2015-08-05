# This class holds the configuration used to generate the html - further documentation will follow once it can use more
# than just the default mappings
class Json2HtmlConfig
  def get_node(key, value)
    "<div id=\"#{key}_label\">#{humanise(key)}</div><div id=\"#{key}\">#{value}</div>"
  end

  def get_object_head(object_name, _object)
    "<div id=\"#{object_name}_label\">#{humanise(object_name)}</div><div id=\"#{object_name}\">"
  end

  def get_object_footer(_object_name, _object)
    '</div>'
  end

  def get_array_head(array_name, _array)
    "<ul id=\"#{array_name}\">"
  end

  def get_array_footer(_array_name, _array)
    '</ul>'
  end

  def get_array_item_head(_array_name, _array, _array_item, _index)
    '<li>'
  end

  def get_array_item_footer(_array_name, _array, _array_item, _index)
    '</li>'
  end

  def humanise(string)
    string.split('_').map(&:capitalize).join(' ')
  end
end
