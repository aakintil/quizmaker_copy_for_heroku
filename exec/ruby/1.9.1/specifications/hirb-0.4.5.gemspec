# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hirb}
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Gabriel Horner}]
  s.date = %q{2011-04-24}
  s.description = %q{Hirb provides a mini view framework for console applications and uses it to improve ripl(irb)'s default inspect output. Given an object or array of objects, hirb renders a view based on the object's class and/or ancestry. Hirb offers reusable views in the form of helper classes. The two main helpers, Hirb::Helpers::Table and Hirb::Helpers::Tree, provide several options for generating ascii tables and trees. Using Hirb::Helpers::AutoTable, hirb has useful default views for at least ten popular database gems i.e. Rails' ActiveRecord::Base. Other than views, hirb offers a smart pager and a console menu. The smart pager only pages when the output exceeds the current screen size. The menu is used in conjunction with tables to offer two dimensional menus.}
  s.email = %q{gabriel.horner@gmail.com}
  s.extra_rdoc_files = [%q{README.rdoc}, %q{LICENSE.txt}]
  s.files = [%q{README.rdoc}, %q{LICENSE.txt}]
  s.homepage = %q{http://tagaholic.me/hirb/}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{tagaholic}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{A mini view framework for console/irb that's easy to use, even while under its influence.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bacon>, [">= 1.1.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<mocha-on-bacon>, [">= 0"])
      s.add_development_dependency(%q<bacon-bits>, [">= 0"])
    else
      s.add_dependency(%q<bacon>, [">= 1.1.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<mocha-on-bacon>, [">= 0"])
      s.add_dependency(%q<bacon-bits>, [">= 0"])
    end
  else
    s.add_dependency(%q<bacon>, [">= 1.1.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<mocha-on-bacon>, [">= 0"])
    s.add_dependency(%q<bacon-bits>, [">= 0"])
  end
end
