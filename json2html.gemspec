# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json2html/version'

Gem::Specification.new do |spec|
  spec.name          = 'json2html'
  spec.version       = Json2Html::VERSION
  spec.authors       = ['Gareth Smyth']
  spec.email         = ['']

  spec.summary       = %q{This gem allows simple conversion of json to html.}
  spec.homepage      = 'https://github.com/gareth-smyth/json2html'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency 'json'
end
