require 'forwardable'
module LanguageIdentifier
  #contain a collection of languages, indexed by the language name such as :ENGLISH, :FRENCH
  class Languages
    extend Forwardable
    include Enumerable

    attr_reader :languages

    def_delegators :languages, :each, :include?, :[], :size

    def self.build_with_seeds language_seeds_dir
      languages = new
      Dir.foreach(language_seeds_dir) do |filename|
        languages.add_words_from_file language_seeds_dir + filename if filename =~/^[A-Z]+.\d/
      end
      languages
    end

    def initialize
      @languages={}
    end

    def add_words_to_language language, text
      language_obj = @languages[language] ||= Language.new(language)
      language_obj.add_words(text) unless text.nil? or text.empty?
    end

    # Read the file and add all the words contained in given file to the language
    def add_words_from_file filename
      language_name = File.basename(filename, ".*").to_sym # using symbol for quick search
      add_words_to_language(language_name, File.read(filename)) unless File.zero?(filename)
    end
  end
end
