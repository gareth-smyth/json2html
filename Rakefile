require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'cucumber'
require 'cucumber/rake/task'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end
YARD::Rake::YardocTask.new do |task|
  task.files = ['./lib/json2html/version.rb','./lib/json2html.rb']
end

task :default => ['rubocop:auto_correct', :spec, :features, :yard]
