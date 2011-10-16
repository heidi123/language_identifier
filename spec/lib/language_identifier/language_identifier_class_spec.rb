require 'spec_helper'

describe LanguageIdentifierClass do
   it {respond_to :build_with_seeds,:add_words_in_str_to_language, :add_words_from_file, :guess_language_for_file, :guess_language_for_str}
end