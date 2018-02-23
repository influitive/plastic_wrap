# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plastic_wrap/version'

Gem::Specification.new do |gem|
  gem.name          = "plastic_wrap"
  gem.version       = PlasticWrap::VERSION
  gem.authors       = ["Craig Savolainen", 'Enric Ribas']
  gem.email         = ["csavolaingn@gmail.com", 'enric@jigsawsmallbusiness.com']
  gem.description   = %q{Decorator to help with the boilerplate of using Rails helpers. It gently wraps your classes to keep your views fresh.}
  gem.summary       = %q{}
  gem.homepage      = "http://github.com/influitive/plastic_wrap"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('rails')

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry"
end
