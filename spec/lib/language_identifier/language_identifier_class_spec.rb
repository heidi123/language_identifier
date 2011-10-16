require 'spec_helper'

describe LanguageIdentifierClass do
   it "should include LanguageIdenfier Module" do
      LanguageIdentifierClass.include_modules.should include LanguageIdenfier
   end
end