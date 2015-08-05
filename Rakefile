require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new
YARD::Rake::YardocTask.new do |task|
  task.files = ['./lib/json2html/version.rb','./lib/json2_html.rb']
end

task :default => ['rubocop:auto_correct', :spec, :yard]
