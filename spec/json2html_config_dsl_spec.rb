require 'spec_helper'

describe Json2HtmlConfig do
  include HtmlHelper

  context 'when no configuration is supplied' do
    subject(:config) { Json2HtmlConfig.new }

    it 'uses the default config for a node' do
      expect(config.get_node('key', 'val', 'name')).to eq('<div id="key_label">Name</div><div id="key">val</div>')
    end

    it 'uses the default config for an object header' do
      expect(config.get_object_head('key', nil, 'name')).to eq('<div id="key_label">Name</div><div id="key">')
    end

    it 'uses the default config for an object footer' do
      expect(config.get_object_footer(nil, nil, nil)).to eq('</div>')
    end

    it 'uses the default config for an array header' do
      expect(config.get_array_head('key', nil, nil)).to eq('<ul id="key">')
    end

    it 'uses the default config for an array footer' do
      expect(config.get_array_footer(nil, nil, nil)).to eq('</ul>')
    end

    it 'uses the default config for an array item header' do
      expect(config.get_array_item_head(nil, nil, nil, nil, nil)).to eq('<li>')
    end

    it 'uses the default config for an array footer' do
      expect(config.get_array_item_footer(nil, nil, nil, nil, nil)).to eq('</li>')
    end
  end

  context 'when some configuration is provided' do
    subject(:config) do
      Json2HtmlConfig.new do
        node 'some new node text'
      end
    end

    it 'overrides only the configuration requested' do
      expect(config.get_node(nil, nil, nil)).to eq('some new node text')
      expect(config.get_object_footer(nil, nil, nil)).to eq('</div>')
    end
  end
end
