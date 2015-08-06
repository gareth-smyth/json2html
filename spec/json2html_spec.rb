require 'spec_helper'

describe Json2Html do
  include HtmlHelper

  it 'has a version number' do
    expect(Json2Html::VERSION).not_to be nil
  end

  it 'should convert json number node to div' do
    html = subject.to_html('{"my_value":13.5}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 2])).text).to eq('13.5')
  end

  it 'should add a label to the html for the node' do
    html = subject.to_html('{"my_value":13.5}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 1])).text).to eq('My Value')
  end

  it 'should convert json text node to a div' do
    html = subject.to_html('{"my_value":"some text"}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 2])).text).to eq('some text')
  end

  it 'should convert null json into empty div' do
    html = subject.to_html('{"my_value":null}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 2])).text).to eq('')
  end

  it 'should convert true json value into div with value true' do
    html = subject.to_html('{"my_value":true}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 2])).text).to eq('true')
  end

  it 'should convert false json value into div with value false' do
    html = subject.to_html('{"my_value":false}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 2])).text).to eq('false')
  end

  it 'should create a number of divs for json array' do
    html = subject.to_html('{"my_value":["string", 2.4, false]}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 1, 1, 2])).text).to eq('string')
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 2, 1, 2])).text).to eq('2.4')
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 3, 1, 2])).text).to eq('false')
  end

  it 'should create a div with internal divs each with unique ids for a json object' do
    html = subject.to_html('{"my_value":{"child1":"a", "child2":"b"}}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 1, 2])).text).to eq('a')
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 2, 2])).text).to eq('b')
  end

  it 'should create a label div with unique id for a json object' do
    html = subject.to_html('{"my_value":{"child1":"a", "child2":"b"}}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 1])).text).to eq('My Value')
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 1, 1])).text).to eq('Child1')
  end

  it 'should create a complex structure' do
    html = subject.to_html('{"child1":{"grandchild1":"value1","grandchild2":[6,7,8]},
                             "child2":[{"grandchild3":"value2" }]}')

    parsed_html = parse(html)
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 1, 2])).text).to eq('value1')
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 2, 2, 1, 1, 2])).text).to eq('6')
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 2, 2, 2, 1, 2])).text).to eq('7')
    expect(parsed_html.css(generate_css_div_selectors([1, 2, 2, 2, 3, 1, 2])).text).to eq('8')
    expect(parsed_html.css(generate_css_div_selectors([2, 2, 1, 1, 2, 1, 2])).text).to eq('value2')
  end
end
