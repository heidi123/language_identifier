require 'set'
require 'forwardable'

class String
  def illegal_language? illegal_chars=/[^a-zA-Z\-\s\.,:;?]/
    self =~ illegal_chars
  end
  #Return an Enumermator for the words in str
  #With a block,  passes each word in str to the block and returns the original string            str.each_word { |word|  block }
  def words sep=/[,\.?:;\s]\s*/
    #self.scan(/\w+\-?\w+/) {|word| yield word if block_given?}
    self.split(sep).each {|word| yield word if block_given?}
  end
  alias each_word words
end

class Language
  extend Forwardable
  include Enumerable
  attr_accessor :name, :dict


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
  # Raise illegalLanguageError  if the string  contain  any characters other than  Latin alphabet characters,  punctuation characters   . , ; : ? and single space characters
  def add_words lang_str
    raise IllegalLanguageError, "Illegal characters contain #{$~} in #{lang_str}" if lang_str.illegal_language? LanguageIdentifier::IllegalCharacters
    lang_str.words(LanguageIdentifier::Delimiter){|word| add word}
    self
  end

end

