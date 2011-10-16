require 'spec_helper'


describe String do
  describe "illegal_char?" do
    it "should detect illegal character in a given string" do
      "Nyuu-seihin$".should be_illegal_language
    end

    it "should return false if the given string does not contain any illegal chars" do
      "full-time".should_not be_illegal_language
      "Pan wa doko desuka?".should_not be_illegal_language
    end
  end

  describe "words" do
     it "should return an array of words in str" do
       "Hello, Bob.".words.should ==["Hello", "Bob"]
     end
     it "should call the given block for each word in string and return an array of the words" do
       result=[]
       "Hello Bob?".words(/[\s?]/) {|word| result << word}.should eql ["Hello", "Bob"]
       result.should == ["Hello", "Bob"]
     end

  end

end
describe Language do

  describe "add" do
    it "should add new word (ignore case) to language" do
      Language.new(:ENGLISH).add("Hello").should include("hello")
    end

    it "should not add duplicate word (ignore case) to language" do
      Language.new(:ENGLISH).add("Hello").add("HELLO").size.should eql 1
    end
  end


  describe "add words" do
    it "should add all the new words  contained in the given string to the language" do
      english = Language.new(:ENGLISH).add_words("Hello, bob. how are you")
      english.should include("hello")
      english.should include("Bob")
      english.should include("how")
      english.size.should eql 5
    end

    it "should raise error if illegal characters contained in the given string" do
      lambda{
       Language.new(:ENGLISH).add_words("Hello bob$")
      }.should raise_error(IllegalLanguageError)
    end
  end


end
