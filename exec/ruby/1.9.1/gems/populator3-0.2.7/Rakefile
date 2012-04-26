require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('populator3', '0.2.7') do |p|
  p.summary        = "Mass populate an Active Record database."
  p.description    = "Mass populate an Active Record database."
  p.url            = "http://github.com/yumitsu/populator3"
  p.author         = 'Ryan Bates, Alex Zinchenko'
  p.email          = "ryan (at) railscasts (dot) com, admloki (at) gmail (dot) com"
  p.ignore_pattern = ["script/*", "**/*.sqlite3", "tmp/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
