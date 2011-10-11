require 'set'
require 'forwardable'


class Language
  extend Forwardable
  include Enumerable
  attr_accessor :name, :dict

  IllegalCharacters =  /[^a-zA-Z\-\s\.,:;?]/
  WordPattern =   /[a-zA-Z]+-?[a-zA-Z]+/
  def_delegators :dict, :each, :size

  def initialize name
     @name = name
     @dict = Set.new
  end

  def add word
    @dict.add word.downcase
    self
  end

  def include? word
    @dict.include? word.downcase
  end
  # It will scan the words from a given language string,  and include them in dictionary (case ito be ignored).
  # Raise IIllegalLanguageError  if the string  contain  any characters other than  Latin alphabet characters,  punctuation characters   . , ; : ? and single space characters
  def add_words lang_str
    Language::each_word(lang_str){|word| add word}
    self
  end


  # Calls the block for each word in the given string, passing each word as parameter
  def self.each_word lang_str
    raise IllegalLanguageError, "Illegal characters contain #{$~} in #{lang_str}" if illegal_char? lang_str
    lang_str.scan(WordPattern).each {|word| yield word if block_given?}
  end

  def self.illegal_char? lang_str
    lang_str =~ IllegalCharacters
  end
end