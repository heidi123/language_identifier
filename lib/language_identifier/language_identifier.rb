require 'forwardable'

module LanguageIdentifier
  extend Forwardable
  LANGUAGE_FILES_LOC =  "./lib/seeds/"

  def initiliaze
    build_languages_from_seeds
  end

  def guess_language_for_file filename
    guess_language_for_str File.read(filename)
  end

  #Guess the language for a given text based on the  sum of  the occurrence of  its words in the  dictionary of language
  # Retun " UNKNOWN" if the sum of the occurences of each word in any languages in the collection is 0
  def guess_language_for_str text

    language_weights={}
    Language.each_word(text) {|word|
      languages.each {|name, language|
        language_weights[name] ||= 0
        language_weights[name] += 1 if language.include?(word.downcase)
      }
    }

    my_language = language_weights.sort{|a,b| a[1] <=> b[1]}.last[0]
    language_weights[my_language] > 0 ? my_language : "UNKNOWN"
  end



  #Build all the language dictionaries  from the files  in the seeds folder
  def build_languages_from_seeds
    Dir.foreach(LANGUAGE_FILES_LOC) do |filename|
      build_language_with_file filename  if filename =~/^[A-Z]+.\d/
    end
    self
  end

  #Return a collection of languages
  def languages
    @languages ||= {}
  end

  #Return the language obj for the given Language name
  def language  language_name
     languages[language_name] ||= Language.new language_name
  end

  # Read the file and add all the words contained in given file to the language
  def build_language_with_file filename
    language_name =  File.basename(filename, ".*")
    language(language_name).add_words( File.read(LANGUAGE_FILES_LOC + filename) ) unless File.zero?(LANGUAGE_FILES_LOC + filename)
  end


end
