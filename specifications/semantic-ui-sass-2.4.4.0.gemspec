# -*- encoding: utf-8 -*-
# stub: semantic-ui-sass 2.4.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "semantic-ui-sass".freeze
  s.version = "2.4.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["doabit".freeze]
  s.date = "2021-06-18"
  s.description = "Semantic UI, converted to Sass and ready to drop into Rails, Compass, or Sprockets.".freeze
  s.email = ["doinsist@gmail.com".freeze]
  s.homepage = "http://github.com/doabit/semantic-ui-sass".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "Semantic UI, converted to Sass and ready to drop into Rails, Compass, or Sprockets.".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 1.3"])
  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<sassc>.freeze, [">= 0"])
  s.add_development_dependency(%q<sassc-rails>.freeze, [">= 0"])
  s.add_development_dependency(%q<sprockets-rails>.freeze, [">= 2.1.3"])
  s.add_development_dependency(%q<pry>.freeze, [">= 0"])
  s.add_development_dependency(%q<dotenv>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec-rails>.freeze, [">= 3.0"])
  s.add_development_dependency(%q<rails>.freeze, [">= 3.2.0"])
  s.add_development_dependency(%q<autoprefixer-rails>.freeze, [">= 0"])
end
