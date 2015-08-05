require 'spec_helper'

describe Json2HtmlConfig do
  include HtmlHelper

  context 'when no config is supplied' do
    it 'returns the default node template' do
      expect(subject.get_node('name', 'val')).to eq('<div id="name_label">Name</div><div id="name">val</div>')
    end

    it 'returns the default object head template' do
      expect(subject.get_object_head('name', nil)).to eq('<div id="name_label">Name</div><div id="name">')
    end

    it 'returns the default object footer' do
      expect(subject.get_object_footer(nil, nil)).to eq('</div>')
    end

    it 'returns the default array head' do
      expect(subject.get_array_head('name', nil)).to eq('<ul id="name">')
    end

    it 'returns the default array foot' do
      expect(subject.get_array_footer(nil, nil)).to eq('</ul>')
    end

    it 'returns the default array item head' do
      expect(subject.get_array_item_head(nil, nil, nil, nil)).to eq('<li>')
    end

    it 'returns the default array item foot' do
      expect(subject.get_array_item_footer(nil, nil, nil, nil)).to eq('</li>')
    end
  end
end
