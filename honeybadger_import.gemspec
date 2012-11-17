# -*- encoding: utf-8 -*-
require File.expand_path('../lib/honeybadger_import/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Glenn Gillen"]
  gem.email         = ["me@glenngillen.com"]
  gem.description   = %q{A simple command line tool to migrate data from Airbrake to Honeybadger}
  gem.summary       = %q{CLI tool for migrating data from Airbrake to Honeybadger}
  gem.homepage      = "https://github.com/glenngillen/honeybadger_import"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "honeybadger_import"
  gem.require_paths = ["lib"]
  gem.version       = HoneybadgerImport::VERSION

  gem.add_dependency "airbrake-api"
  gem.add_dependency "honeybadger"
end
