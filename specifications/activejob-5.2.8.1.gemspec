# -*- encoding: utf-8 -*-
# stub: activejob 5.2.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "activejob".freeze
  s.version = "5.2.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/rails/rails/blob/v5.2.8.1/activejob/CHANGELOG.md", "source_code_uri" => "https://github.com/rails/rails/tree/v5.2.8.1/activejob" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2022-07-12"
  s.description = "Declare job classes that can be run by a variety of queueing backends.".freeze
  s.email = "david@loudthinking.com".freeze
  s.homepage = "http://rubyonrails.org".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Job framework with pluggable queues.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, ["= 5.2.8.1"])
  s.add_runtime_dependency(%q<globalid>.freeze, [">= 0.3.6"])
end
