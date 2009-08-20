# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{page_glimpse}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonas Grimfelt"]
  s.date = %q{2009-08-20}
  s.description = %q{A little Ruby wrapper for the PageGlimpse API (http://pageglimpse.com) for generating webpage snapshots - glimpses - in a snap.}
  s.email = %q{grimen@gmail.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "MIT-LICENSE",
    "README.textile",
    "Rakefile",
    "lib/page_glimpse.rb",
    "rails/init.rb",
    "test/page_glimse_test.rb"
  ]
  s.homepage = %q{http://github.com/grimen/page_glimpse/tree/master}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{A little Ruby wrapper for the PageGlimpse API (http://pageglimpse.com) for generating webpage snapshots - glimpses - in a snap.}
  s.test_files = [
    "test/page_glimse_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
