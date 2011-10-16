require 'forwardable'

module LanguageIdentifier extend Forwardable
  LANGUAGE_FILES_LOC =  "./lib/seeds/"
  IllegalCharacters =  /[^a-zA-Z\-\s\.,:;?]/
  Delimiter =/[,\.?:;\s]\s*/

  attr_reader :languages

  def_delegators :languages, :add_words_to_language, :add_words_from_file

  alias :add_words_in_str_to_language  :add_words_to_language

  def build_with_seeds  seeds=LANGUAGE_FILES_LOC
    @languages= LanguageIdentifier::Languages.build_with_seeds seeds
    self
  end

  def initialize languages=nil
    @languages = languages || LanguageIdentifier::Languages.new
  end

  def guess_language_for_file filename
    guess_language_for_str File.read(filename)
  end

  #Guess the language for a given text based on the  sum of  the occurrence of  its words in the  dictionary of language
  # Return " UNKNOWN" if the sum of the occurrences of each word in any languages in the collection is 0
  def guess_language_for_str text
    raise IllegalLanguageError, "Illegal characters #{$~} were detected in #{text}" if text.illegal_language?  IllegalCharacters
    language_weights={}
    #iterate the each word in text
    text.words(Delimiter) do |word|
      languages.each do |name, language|
        language_weights[name] ||= 0
        language_weights[name] += 1 if language.include?(word.downcase)
      end
    end
    my_language = language_weights.sort{|a,b| a[1] <=> b[1]}.last[0]
    language_weights[my_language] > 0 ? my_language.to_s : "UNKNOWN"
  end


end
