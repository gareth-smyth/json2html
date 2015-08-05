require 'spec_helper'

describe Json2Html do
  it 'has a version number' do
    expect(Json2Html::VERSION).not_to be nil
  end

  it 'should convert json number node to a div with id' do
    html = subject.to_html('{"my_value":13.5}')
    expect(html).to eq('<div id="my_value">13.5</div>')
  end

  it 'should convert json text node to a div with id' do
    html = subject.to_html('{"my_value":"some text"}')
    expect(html).to eq('<div id="my_value">some text</div>')
  end

  it 'should convert null json into empty div with id' do
    html = subject.to_html('{"my_value":null}')
    expect(html).to eq('<div id="my_value"></div>')
  end

  it 'should convert true json value into div with id and value true' do
    html = subject.to_html('{"my_value":true}')
    expect(html).to eq('<div id="my_value">true</div>')
  end

  it 'should convert false json value into div with id and value false' do
    html = subject.to_html('{"my_value":false}')
    expect(html).to eq('<div id="my_value">false</div>')
  end
end
