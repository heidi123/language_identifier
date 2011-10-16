require 'bundler'

require 'bundler/gem_tasks'


# Cucumber configurations
require 'cucumber/rake/task'
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--format pretty"
end

# RSpec

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)


# other Project tasks
Dir[File.join(File.dirname(__FILE__), "tasks", "*.rb")].each { |file| require file }

namespace :nbn do
  desc "Run all tests"
  task :test => ["spec","cucumber"]
end


task :default => ["nbn:test"]
