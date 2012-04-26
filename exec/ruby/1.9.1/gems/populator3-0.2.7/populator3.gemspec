# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{populator3}
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Bates, Alex Zinchenko"]
  s.date = %q{2010-11-11}
  s.description = %q{Mass populate an Active Record database.}
  s.email = %q{ryan (at) railscasts (dot) com, admloki (at) gmail (dot) com}
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README.rdoc", "TODO", "lib/populator.rb", "lib/populator/adapters/abstract.rb", "lib/populator/adapters/oracle.rb", "lib/populator/adapters/postgresql.rb", "lib/populator/adapters/sqlite.rb", "lib/populator/factory.rb", "lib/populator/model_additions.rb", "lib/populator/random.rb", "lib/populator/record.rb", "tasks/deployment.rake", "tasks/spec.rake"]
  s.files = ["CHANGELOG", "LICENSE", "Manifest", "README.rdoc", "Rakefile", "TODO", "lib/populator.rb", "lib/populator/adapters/abstract.rb", "lib/populator/adapters/oracle.rb", "lib/populator/adapters/postgresql.rb", "lib/populator/adapters/sqlite.rb", "lib/populator/factory.rb", "lib/populator/model_additions.rb", "lib/populator/random.rb", "lib/populator/record.rb", "populator3.gemspec", "spec/README", "spec/example_database.yml", "spec/models/category.rb", "spec/models/product.rb", "spec/populator/factory_spec.rb", "spec/populator/model_additions_spec.rb", "spec/populator/random_spec.rb", "spec/populator/record_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/deployment.rake", "tasks/spec.rake"]
  s.homepage = %q{http://github.com/yumitsu/populator3}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Populator3", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{populator3}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Mass populate an Active Record database.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
