require 'spec_helper'

describe LanguageIdentifier do


  before (:all) do
    class Dummy
      include LanguageIdentifier
    end
    @language_identifier = Dummy.new
  end

  describe "guess_language" do
    it "should guess ENGLISH" do
      string = "Some English word here"
      @language_identifier.add_words_to_language :ENGLISH, string
      @language_identifier.guess_language_for_str(string).should =="ENGLISH"
    end
    it "should guess FRENCH" do
      string = "On vous donne un certain nombre de fichiers  partir dun certain"
      @language_identifier.add_words_to_language :FRENCH, string
      @language_identifier.guess_language_for_str(string).should =="FRENCH"
    end
    it "should guess GAELIC" do
      text = "Thathar gun teid David Norris a thaghadh na  anns an Taghadh."
      @language_identifier.add_words_to_language :GAELIC, text
      @language_identifier.guess_language_for_str(text).should =="GAELIC"
    end
    it "should return UNKNOWN if failed to guess the guess for the given text" do
      string = "Zhao Shang Hao"
      @language_identifier.guess_language_for_str(string).should =="UNKNOWN"
    end

  end

  describe "guess_language_for_file " do
    it "should guess ENGLISH for file TEXT.txt" do
      @language_identifier.add_words_to_language :ENGLISH, "Some English word here"
      filename ="TEXT.txt"
      File.should_receive(:read).with(filename).and_return("Some English word here")
      @language_identifier.guess_language_for_file(filename).should =="ENGLISH"
    end
  end

  describe "build_with_seeds" do
    it "should build the Language idenfifier from a number of files in seeds folder" do
      @language_identifier.build_with_seeds(LanguageIdentifier::LANGUAGE_FILES_LOC)
      @language_identifier.should_not be_nil
      @language_identifier.languages.should include :ENGLISH
      @language_identifier.languages.should include :FRENCH
      @language_identifier.languages.should include :GAELIC
      @language_identifier.languages.should include :JAPANESE
      @language_identifier.languages.size.should eql 4
    end
  end


end


