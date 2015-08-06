$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'json2html'
require 'json2html_config_dsl'
require 'nokogiri'

module HtmlHelper
  def parse(html)
    Nokogiri::HTML.parse(html)do |config|
      config.strict
    end
  end

  # This method is very specific to a hierarchy of divs and builds up a css selector string of the following type
  # /html/body/div:nth-of-type[1]/div:nth-of-type(1)/div:nth-of-type(2)/text() based on the inpiut array for the
  # positions in each of the nth-of-type selectors.
  #
  # @example
  # Given the html:
  # <html>
  #  <body>
  #   <div>                 #pos 1
  #    <div>                #pos 1,1
  #     <div>value1</div>   #pos 1,1,1
  #     <div>value2</div>   #pos 1,1,2
  #    </div>
  #   </div>
  #   <div>                 #pos 2
  #    <div>value3</div>    #pos 2,1
  #   </div>
  #  </body>
  # </html>
  #
  # then in order to get "value1" call generate_css_div_selectors[1,1,1]
  #      in order to get "value2" call generate_css_div_selectors[1,1,2]
  #      in order to get "value3" call generate_css_div_selectors[2,1]
  #
  def generate_css_div_selectors(positions)
    css = '/html/body'
    positions.each do |position|
      css << '/div'
      css << ":nth-of-type(#{position})"
    end
    css << '/text()'
  end
end
