# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deep_fetch/version'

Gem::Specification.new do |gem|
  gem.name          = "deep_fetch"
  gem.version       = DeepFetch::VERSION
  gem.authors       = ["Tomasz Pewiński"]
  gem.email         = ["pewniak747@gmail.com"]
  gem.description   = %q{easily fetch values from nested ruby hashes}
  gem.summary   = %q{easily fetch values from nested ruby hashes}
  gem.homepage      = "https://github.com/pewniak747/deep_fetch"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'rake'
end
