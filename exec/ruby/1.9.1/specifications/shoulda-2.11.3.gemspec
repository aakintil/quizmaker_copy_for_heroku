# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{shoulda}
  s.version = "2.11.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Tammer Saleh}, %q{Joe Ferris}, %q{Ryan McGeary}, %q{Dan Croak}, %q{Matt Jankowski}]
  s.date = %q{2010-08-02}
  s.description = %q{Making tests easy on the fingers and eyes}
  s.email = %q{support@thoughtbot.com}
  s.executables = [%q{convert_to_should_syntax}]
  s.extra_rdoc_files = [%q{README.rdoc}, %q{CONTRIBUTION_GUIDELINES.rdoc}]
  s.files = [%q{bin/convert_to_should_syntax}, %q{README.rdoc}, %q{CONTRIBUTION_GUIDELINES.rdoc}]
  s.homepage = %q{http://thoughtbot.com/community/}
  s.rdoc_options = [%q{--line-numbers}, %q{--main}, %q{README.rdoc}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{shoulda}
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Making tests easy on the fingers and eyes}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
