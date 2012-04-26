# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cucumber-rails}
  s.version = "0.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Aslak Hellesøy}, %q{Dennis Blöte}, %q{Rob Holland}]
  s.date = %q{2011-06-06}
  s.description = %q{Cucumber Generators and Runtime for Rails}
  s.email = %q{cukes@googlegroups.com}
  s.extra_rdoc_files = [%q{LICENSE}, %q{README.md}, %q{History.txt}]
  s.files = [%q{LICENSE}, %q{README.md}, %q{History.txt}]
  s.homepage = %q{http://cukes.info}
  s.rdoc_options = [%q{--charset=UTF-8}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{cucumber-rails-0.5.2}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cucumber>, [">= 0.10.5"])
      s.add_runtime_dependency(%q<rack-test>, [">= 0.5.7"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.4"])
      s.add_runtime_dependency(%q<capybara>, [">= 1.0.0.rc1"])
      s.add_development_dependency(%q<rails>, ["= 3.1.0.rc1"])
      s.add_development_dependency(%q<rake>, ["= 0.8.7"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.14"])
      s.add_development_dependency(%q<aruba>, [">= 0.3.7"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 1.3.3"])
      s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.6.1"])
      s.add_development_dependency(%q<factory_girl>, [">= 2.0.0.beta2"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0.6.7"])
      s.add_development_dependency(%q<mongoid>, [">= 2.0.2"])
      s.add_development_dependency(%q<bson_ext>, [">= 1.3.1"])
      s.add_development_dependency(%q<turn>, [">= 0.8.2"])
      s.add_development_dependency(%q<sass>, [">= 3.1.1"])
      s.add_development_dependency(%q<coffee-script>, [">= 2.2.0"])
      s.add_development_dependency(%q<uglifier>, [">= 0.5.4"])
      s.add_development_dependency(%q<jquery-rails>, [">= 1.0.9"])
    else
      s.add_dependency(%q<cucumber>, [">= 0.10.5"])
      s.add_dependency(%q<rack-test>, [">= 0.5.7"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
      s.add_dependency(%q<capybara>, [">= 1.0.0.rc1"])
      s.add_dependency(%q<rails>, ["= 3.1.0.rc1"])
      s.add_dependency(%q<rake>, ["= 0.8.7"])
      s.add_dependency(%q<bundler>, [">= 1.0.14"])
      s.add_dependency(%q<aruba>, [">= 0.3.7"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 1.3.3"])
      s.add_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_dependency(%q<rspec-rails>, [">= 2.6.1"])
      s.add_dependency(%q<factory_girl>, [">= 2.0.0.beta2"])
      s.add_dependency(%q<database_cleaner>, [">= 0.6.7"])
      s.add_dependency(%q<mongoid>, [">= 2.0.2"])
      s.add_dependency(%q<bson_ext>, [">= 1.3.1"])
      s.add_dependency(%q<turn>, [">= 0.8.2"])
      s.add_dependency(%q<sass>, [">= 3.1.1"])
      s.add_dependency(%q<coffee-script>, [">= 2.2.0"])
      s.add_dependency(%q<uglifier>, [">= 0.5.4"])
      s.add_dependency(%q<jquery-rails>, [">= 1.0.9"])
    end
  else
    s.add_dependency(%q<cucumber>, [">= 0.10.5"])
    s.add_dependency(%q<rack-test>, [">= 0.5.7"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.4"])
    s.add_dependency(%q<capybara>, [">= 1.0.0.rc1"])
    s.add_dependency(%q<rails>, ["= 3.1.0.rc1"])
    s.add_dependency(%q<rake>, ["= 0.8.7"])
    s.add_dependency(%q<bundler>, [">= 1.0.14"])
    s.add_dependency(%q<aruba>, [">= 0.3.7"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 1.3.3"])
    s.add_dependency(%q<rspec>, [">= 2.6.0"])
    s.add_dependency(%q<rspec-rails>, [">= 2.6.1"])
    s.add_dependency(%q<factory_girl>, [">= 2.0.0.beta2"])
    s.add_dependency(%q<database_cleaner>, [">= 0.6.7"])
    s.add_dependency(%q<mongoid>, [">= 2.0.2"])
    s.add_dependency(%q<bson_ext>, [">= 1.3.1"])
    s.add_dependency(%q<turn>, [">= 0.8.2"])
    s.add_dependency(%q<sass>, [">= 3.1.1"])
    s.add_dependency(%q<coffee-script>, [">= 2.2.0"])
    s.add_dependency(%q<uglifier>, [">= 0.5.4"])
    s.add_dependency(%q<jquery-rails>, [">= 1.0.9"])
  end
end
