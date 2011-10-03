require 'rubygems'
require 'rspec'
require "#{File.dirname(__FILE__)}/../lib/boot.rb"

RSpec.configure do |config|
  config.mock_framework = :mocha
end