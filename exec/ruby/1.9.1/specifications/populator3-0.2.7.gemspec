# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{populator3}
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Ryan Bates, Alex Zinchenko}]
  s.date = %q{2010-11-10}
  s.description = %q{Mass populate an Active Record database.}
  s.email = %q{ryan (at) railscasts (dot) com, admloki (at) gmail (dot) com}
  s.extra_rdoc_files = [%q{CHANGELOG}, %q{LICENSE}, %q{README.rdoc}, %q{TODO}, %q{lib/populator.rb}, %q{lib/populator/adapters/abstract.rb}, %q{lib/populator/adapters/oracle.rb}, %q{lib/populator/adapters/postgresql.rb}, %q{lib/populator/adapters/sqlite.rb}, %q{lib/populator/factory.rb}, %q{lib/populator/model_additions.rb}, %q{lib/populator/random.rb}, %q{lib/populator/record.rb}, %q{tasks/deployment.rake}, %q{tasks/spec.rake}]
  s.files = [%q{CHANGELOG}, %q{LICENSE}, %q{README.rdoc}, %q{TODO}, %q{lib/populator.rb}, %q{lib/populator/adapters/abstract.rb}, %q{lib/populator/adapters/oracle.rb}, %q{lib/populator/adapters/postgresql.rb}, %q{lib/populator/adapters/sqlite.rb}, %q{lib/populator/factory.rb}, %q{lib/populator/model_additions.rb}, %q{lib/populator/random.rb}, %q{lib/populator/record.rb}, %q{tasks/deployment.rake}, %q{tasks/spec.rake}]
  s.homepage = %q{http://github.com/yumitsu/populator3}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Populator3}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{populator3}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Mass populate an Active Record database.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
