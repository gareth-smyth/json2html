# This class holds the configuration used to generate the html - further documentation will follow once it can use more
# than just the default mappings
class Json2HtmlConfig
  def initialize(&block)
    defaults.call
    # run the block which can override the defaults
    instance_eval(&block) if block_given?
  end

  def defaults # rubocop:disable Metrics/MethodLength
    proc do
      node '<div class="json-node"><div class="json-node-name">%<name>s</div>'\
           '<div class="json-node-value">%<value>s</div></div>'
      object_head '<div class="json-object"><div class="json-object-name">%<name>s</div><div class="json-object-body">'
      object_footer '</div></div>'
      array_head '<div class="json-array"><div class="json-array-name">%<name>s</div><div class="json-array-body">'
      array_footer '</div></div>'
      array_item_head '<div class="json-array-item">'
      array_item_footer '</div>'
      collapse_array_item_objects true
    end
  end

  def collapse_array_item_objects(collapse = nil)
    @collapse_array_item_objects = collapse unless collapse.nil?
    @collapse_array_item_objects
  end

  def node(template_string)
    @node_template = template_string
  end

  def get_node(key, value, name)
    @node_template % { key: key, value: value, name: humanise(name) }
  end

  def object_head(template_string)
    @object_head_template = template_string
  end

  def get_object_head(full_key, object, node_name)
    @object_head_template % { key: full_key, object: object, name: humanise(node_name) }
  end

  def object_footer(template_string)
    @object_footer_template = template_string
  end

  def get_object_footer(full_key, object, node_name)
    @object_footer_template % { key: full_key, object: object, name: humanise(node_name) }
  end

  def array_head(template_string)
    @array_head_template = template_string
  end

  def get_array_head(full_key, array, array_name)
    @array_head_template % { key: full_key, array: array, name: humanise(array_name) }
  end

  def array_footer(template_string)
    @array_footer_template = template_string
  end

  def get_array_footer(full_key, array, array_name)
    @array_footer_template % { key: full_key, array: array, name: humanise(array_name) }
  end

  def array_item_head(template_string)
    @array_item_head_template = template_string
  end

  def get_array_item_head(full_key, array, array_name, array_item, index)
    @array_item_head_template % { key: full_key, array: array, name: humanise(array_name),
                                  item: array_item, index: index }
  end

  def array_item_footer(template_string)
    @array_item_footer_template = template_string
  end

  def get_array_item_footer(full_key, array, array_name, array_item, index)
    @array_item_footer_template % { key: full_key, array: array, name: humanise(array_name),
                                    item: array_item, index: index }
  end

  def humanise(string)
    string.split('_').map(&:capitalize).join(' ') unless string.to_s == ''
  end
end
