require 'spec_helper'

describe Language do


  it "should add new word to language" do
    english = Language.new "ENGLISH"
    english.add("Hello")
    english.should include("Hello")
    english.size.should eql 1
  end
end
