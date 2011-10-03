require 'set'
require 'forwardable'

class Language
  extend Forwardable
  include Enumerable
  attr_accessor :name, :dictionary

  def_delegators :dictionary, :each, :<<, :add, :size

  def initialize name
     @name = name
     @dictionary = Set.new
  end

end