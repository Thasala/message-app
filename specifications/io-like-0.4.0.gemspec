# -*- encoding: utf-8 -*-
# stub: io-like 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "io-like".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jeremy Bopp".freeze, "Jarred Holman".freeze, "Grant Gardner".freeze, "Jordan Pickwell".freeze]
  s.date = "2025-06-07"
  s.description = "This gem makes it possible to build filters or pipelines for processing data\ninto or out of streams of bytes while maintaining compatibility with native Ruby\nIO classes.  Ruby IO classes may function as both sources and sinks, or entirely\nnew IO implementations may be created.\n".freeze
  s.email = ["jeremy@bopp.net".freeze, "jarred.holman@gmail.com".freeze, "grant@lastweekend.com.au".freeze, "jpickwell@users.noreply.github.com".freeze]
  s.extra_rdoc_files = ["LICENSE".freeze, "NEWS.md".freeze, "README.md".freeze, "rubyspec/LICENSE".freeze]
  s.files = ["LICENSE".freeze, "NEWS.md".freeze, "README.md".freeze, "rubyspec/LICENSE".freeze]
  s.homepage = "http://github.com/javanthropus/io-like".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--title".freeze, "IO::Like Documentation".freeze, "--charset".freeze, "utf-8".freeze, "--line-numbers".freeze, "--inline-source".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "A composable implementation of IO methods.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
  s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
  s.add_development_dependency(%q<github-markup>.freeze, ["~> 3.0"])
  s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.1"])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.20.0"])
end
