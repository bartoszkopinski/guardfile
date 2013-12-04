# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guardfile/version'

Gem::Specification.new do |gem|
  gem.name          = 'guardfile'
  gem.version       = Guardfile::VERSION
  gem.authors       = ['Bartosz Kopinski']
  gem.email         = ['bartosz.kopinski@netguru.pl']
  gem.description   = 'Better Guardfile syntax'
  gem.summary       = 'Better Guardfile syntax'
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'guard', '>= 2.1.1'
  gem.add_development_dependency 'bundler', '>= 1.3.5'
  gem.add_development_dependency 'rake'
end
