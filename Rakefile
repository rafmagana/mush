# -*- encoding: utf-8 -*-
require 'bundler/setup'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "mush"
  gem.summary = %Q{A multiple service URL shortener gem with command-line utilities}
  gem.description = %Q{A gem to shorten URLs using different services, it has one command-line utility for each supported service and one for custom shorteners called 'shorten'.}
  gem.email = "raf.magana@gmail.com"
  gem.homepage = "http://github.com/rafmagana/mush"
  gem.authors = ["Rafael Magana"]
end
Jeweler::GemcutterTasks.new

require 'rake/testtask'
Rake::TestTask.new(:default) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.read('VERSION')
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mush #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
