# This class holds the configuration used to generate the html - further documentation will follow once it can use more
# than just the default mappings
class Json2HtmlConfig
  def get_node(key, value, name)
    "<div id=\"#{key}_label\">#{humanise(name)}</div><div id=\"#{key}\">#{value}</div>"
  end

  def get_object_head(full_key, _object, node_name)
    "<div id=\"#{full_key}_label\">#{humanise(node_name)}</div><div id=\"#{full_key}\">"
  end

  def get_object_footer(_full_key, _object, _node_name)
    '</div>'
  end

  def get_array_head(full_key, _array, _array_name)
    "<ul id=\"#{full_key}\">"
  end

  def get_array_footer(_full_key, _array, _array_name)
    '</ul>'
  end

  def get_array_item_head(_full_key, _array, _array_name, _array_item, _index)
    '<li>'
  end

  def get_array_item_footer(_full_key, _array, _array_name, _array_item, _index)
    '</li>'
  end

  def humanise(string)
    string.split('_').map(&:capitalize).join(' ')
  end
end
