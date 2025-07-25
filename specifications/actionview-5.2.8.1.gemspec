# -*- encoding: utf-8 -*-
# stub: actionview 5.2.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "actionview".freeze
  s.version = "5.2.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/rails/rails/blob/v5.2.8.1/actionview/CHANGELOG.md", "source_code_uri" => "https://github.com/rails/rails/tree/v5.2.8.1/actionview" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2022-07-12"
  s.description = "Simple, battle-tested conventions and helpers for building web pages.".freeze
  s.email = "david@loudthinking.com".freeze
  s.homepage = "http://rubyonrails.org".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.requirements = ["none".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Rendering framework putting the V in MVC (part of Rails).".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, ["= 5.2.8.1"])
  s.add_runtime_dependency(%q<builder>.freeze, ["~> 3.1"])
  s.add_runtime_dependency(%q<erubi>.freeze, ["~> 1.4"])
  s.add_runtime_dependency(%q<rails-html-sanitizer>.freeze, ["~> 1.0", ">= 1.0.3"])
  s.add_runtime_dependency(%q<rails-dom-testing>.freeze, ["~> 2.0"])
  s.add_development_dependency(%q<actionpack>.freeze, ["= 5.2.8.1"])
  s.add_development_dependency(%q<activemodel>.freeze, ["= 5.2.8.1"])
end
