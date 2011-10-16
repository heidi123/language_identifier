require 'spec_helper'

describe LanguageIdentifier::Languages do

  describe "add_words_from_file" do
    before (:all) do
      @languages = LanguageIdentifier::Languages.new
    end

    it "should read the file and add all the words in the given file to the language" do
      filename= "ENGLISH.1"
      File.should_receive(:read).with(LanguageIdentifier::LANGUAGE_FILES_LOC + filename).and_return("Some English here. ")
      language = @languages.add_words_from_file(LanguageIdentifier::LANGUAGE_FILES_LOC + filename)
      @languages.should include :ENGLISH
      @languages[:ENGLISH].should == language
      language.name.should == :ENGLISH
      language.should include "Some"
      language.should include "English"
      language.should include "here"
    end

    it "should add more words to the language from file" do
      filename= "ENGLISH.2"
      size_before_build= @languages[:ENGLISH].size
      File.should_receive(:read).with(LanguageIdentifier::LANGUAGE_FILES_LOC + filename).and_return("Add More words here.")
      @languages.add_words_from_file(LanguageIdentifier::LANGUAGE_FILES_LOC + filename).size.should > size_before_build
      @languages.size.should eql 1
    end

  end

  describe "add_words_to_language" do
    it "should add the words in the given test to language" do
     english = LanguageIdentifier::Languages.new.add_words_to_language(:ENGLISH, "Goodbye, Dennis Ritche")
     english.should include "Goodbye"
    end
  end

  describe "build_with_seeds" do
    it "should should build the languages from the seeds dir" do
     languages = LanguageIdentifier::Languages.build_with_seeds("./lib/seeds/")
     languages.should include :ENGLISH
     languages.should include :FRENCH
     languages.should include :GAELIC
     languages.should_not include :CHINSESE
    end
  end
end
