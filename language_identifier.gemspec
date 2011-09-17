# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "language_identifier/version"

Gem::Specification.new do |s|
  s.name        = "language_identifier"
  s.version     = LanguageIdentifier::VERSION
  s.authors     = ["Heidi Ni"]
  s.email       = ["heidi_ni@yahoo.com"]
  s.homepage    = ""
  s.summary     = %q{Language Identifier}
  s.description = %q{Simply guess  the language based on the frequencies of word in dictionary}

  s.rubyforge_project = "language_identifier"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
