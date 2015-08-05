require 'spec_helper'

describe Json2Html do
  it 'has a version number' do
    expect(Json2Html::VERSION).not_to be nil
  end

  it 'should convert json number node to a div with id' do
    html_with_number = subject.to_html('{"my_number":13.5}')
    expect(html_with_number).to eq('<div id="my_number">13.5</div>')
  end
end
