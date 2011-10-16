Given /^A language identifier built with the words from the given "([^"]*)"$/ do |language_file|
  @language_identifier = LanguageIdentifierClass.new
  @test_data = "./features/test_data/"
  @language_identifier.add_words_from_file  @test_data+language_file
end

When /^Give a file "([^"]*)" in the same format with unknown origin$/ do |test_file|
  @test_data ||= "./features/test_data/"
  @file =  @test_data + test_file
end

Then /^I will identify its language as "([^"]*)"$/ do |language|
  @language_identifier.guess_language_for_file(@file).should eql language
end

Given /^A language identifier built with a number of language files in the seeds folder,$/ do
   @language_identifier = LanguageIdentifierClass.new
   @language_identifier.build_with_seeds "./lib/seeds/"
end
