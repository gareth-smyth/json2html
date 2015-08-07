require 'spec_helper'

describe Json2HtmlConfig do
  include HtmlHelper

  context 'when no configuration is supplied' do
    subject(:config) { Json2HtmlConfig.new }

    it 'uses the default config for a node' do
      expect(config.get_node('key', 'val', 'name')).to eq('<div class="json-node">'\
                                                            '<div class="json-node-name">Name</div>'\
                                                            '<div class="json-node-value">val</div>'\
                                                          '</div>')
    end

    it 'uses the default config for an object header' do
      expect(config.get_object_head('key', nil, 'name')).to eq('<div class="json-object">'\
                                                                 '<div class="json-object-name">Name</div>'\
                                                               '<div>')
    end

    it 'uses the default config for an object footer' do
      expect(config.get_object_footer(nil, nil, nil)).to eq('</div></div>')
    end

    it 'uses the default config for an array header' do
      expect(config.get_array_head('key', nil, 'name')).to eq('<div class="json-array">'\
                                                                '<div class="json-array-name">Name</div>'\
                                                              '<div>')
    end

    it 'uses the default config for an array footer' do
      expect(config.get_array_footer(nil, nil, nil)).to eq('</div></div>')
    end

    it 'uses the default config for an array item header' do
      expect(config.get_array_item_head(nil, nil, nil, nil, nil)).to eq('<div>')
    end

    it 'uses the default config for an array footer' do
      expect(config.get_array_item_footer(nil, nil, nil, nil, nil)).to eq('</div>')
    end
  end

  context 'when some template configuration is provided' do
    subject(:config) do
      Json2HtmlConfig.new do
        node 'some new node text'
      end
    end

    it 'overrides only the configuration requested' do
      expect(config.get_node(nil, nil, nil)).to eq('some new node text')
      expect(config.get_object_footer(nil, nil, nil)).to eq('</div></div>')
    end
  end

  context 'when full template configuration is provided' do
    subject(:config) do
      Json2HtmlConfig.new do
        node 'some new node text'
        object_head 'object head text'
        object_footer 'object footer text'
        array_head 'array head text'
        array_footer 'array footer text'
        array_item_head 'array item head text'
        array_item_footer 'array item footer text'
      end
    end

    it 'overrides all the configuration requested' do
      expect(config.get_node(nil, nil, nil)).to eq('some new node text')
      expect(config.get_object_head(nil, nil, nil)).to eq('object head text')
      expect(config.get_object_footer(nil, nil, nil)).to eq('object footer text')
      expect(config.get_array_head(nil, nil, nil)).to eq('array head text')
      expect(config.get_array_footer(nil, nil, nil)).to eq('array footer text')
      expect(config.get_array_item_head(nil, nil, nil, nil, nil)).to eq('array item head text')
      expect(config.get_array_item_footer(nil, nil, nil, nil, nil)).to eq('array item footer text')
    end
  end
end
