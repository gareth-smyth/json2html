# This class holds the configuration used to generate the html - further documentation will follow once it can use more
# than just the default mappings
class Json2HtmlConfig
  def initialize(&block)
    # set defaults
    node '<div id="%<key>s_label">%<name>s</div><div id="%<key>s">%<value>s</div>'

    # run the block which can override the defaults
    instance_eval(&block) if block_given?
  end

  def node(template_string)
    @node_template = template_string
  end

  def get_node(key, value, name)
    @node_template % { key: key, value: value, name: humanise(name) }
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
    string.split('_').map(&:capitalize).join(' ') unless string.to_s == ''
  end
end
