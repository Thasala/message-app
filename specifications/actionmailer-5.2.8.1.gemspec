# -*- encoding: utf-8 -*-
# stub: actionmailer 5.2.8.1 ruby lib

Gem::Specification.new do |s|
  s.name = "actionmailer".freeze
  s.version = "5.2.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/rails/rails/blob/v5.2.8.1/actionmailer/CHANGELOG.md", "source_code_uri" => "https://github.com/rails/rails/tree/v5.2.8.1/actionmailer" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2022-07-12"
  s.description = "Email on Rails. Compose, deliver, receive, and test emails using the familiar controller/view pattern. First-class support for multipart email and attachments.".freeze
  s.email = "david@loudthinking.com".freeze
  s.homepage = "http://rubyonrails.org".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.requirements = ["none".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Email composition, delivery, and receiving framework (part of Rails).".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionpack>.freeze, ["= 5.2.8.1"])
  s.add_runtime_dependency(%q<actionview>.freeze, ["= 5.2.8.1"])
  s.add_runtime_dependency(%q<activejob>.freeze, ["= 5.2.8.1"])
  s.add_runtime_dependency(%q<mail>.freeze, ["~> 2.5", ">= 2.5.4"])
  s.add_runtime_dependency(%q<rails-dom-testing>.freeze, ["~> 2.0"])
end
