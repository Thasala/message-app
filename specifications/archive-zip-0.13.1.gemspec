# -*- encoding: utf-8 -*-
# stub: archive-zip 0.13.1 ruby lib

Gem::Specification.new do |s|
  s.name = "archive-zip".freeze
  s.version = "0.13.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jeremy Bopp".freeze, "Akira Matsuda".freeze, "Tatsuya Sato".freeze, "Kouhei Sutou".freeze]
  s.date = "2025-06-20"
  s.description = "Archive::Zip provides a simple Ruby-esque interface to creating, extracting, and\nupdating ZIP archives.  This implementation is 100% Ruby and loosely modeled on\nthe archive creation and extraction capabilities of InfoZip's zip and unzip\ntools.\n".freeze
  s.email = ["jeremy@bopp.net".freeze, "ronnie@dio.jp".freeze, "tatsuya.b.sato@rakuten.com".freeze, "kou@clear-code.com".freeze]
  s.homepage = "http://github.com/javanthropus/archive-zip".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Simple, extensible, pure Ruby ZIP archive support.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<io-like>.freeze, ["~> 0.4.0"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 13.0"])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.11"])
  s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
  s.add_development_dependency(%q<github-markup>.freeze, ["~> 3.0"])
  s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.4"])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.20.0"])
end
