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

  it 'should create unordered list of primitive htmls with indexed ids for json array' do
    html = subject.to_html('{"my_value":["string", 2.4, false]}')
    expect(html).to eq('<ul id="my_value"><li><div id="my_value_1">string</div></li>'\
                       '<li><div id="my_value_2">2.4</div></li><li><div id="my_value_3">false</div></li></ul>')
  end

  it 'should create a div with internal divs each with unique ids for a json object' do
    html = subject.to_html('{"my_value":{"child1":"a", "child2":"b"}}')
    expect(html).to eq('<div id="my_value"><div id="my_value_child1">a</div><div id="my_value_child2">b</div></div>')
  end

  it 'should create a complex structure' do
    html = subject.to_html('{"child1":{"grandchild1":"value1","grandchild2":[6,7,8]},
                             "child2":[{"grandchild3":"value2" }]}')
    expect(html).to eq('<div id="child1">'\
                       '<div id="child1_grandchild1">value1</div>'\
                       '<ul id="child1_grandchild2">'\
                       '<li><div id="child1_grandchild2_1">6</div></li>'\
                       '<li><div id="child1_grandchild2_2">7</div></li>'\
                       '<li><div id="child1_grandchild2_3">8</div></li>'\
                       '</ul>'\
                       '</div>'\
                       '<ul id="child2">'\
                       '<li>'\
                       '<div id="child2_1">'\
                       '<div id="child2_1_grandchild3">value2</div>'\
                       '</div>'\
                       '</li>'\
                       '</ul>')
  end
end
