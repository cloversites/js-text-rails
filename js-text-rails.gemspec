# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'js-text-rails/version'

Gem::Specification.new do |spec|
  spec.name          = "js-text-rails"
  spec.version       = JsTextRails::VERSION
  spec.authors       = ["Jackson Ray Hamilton"]
  spec.email         = ["jackson@jacksonrayhamilton.com"]

  spec.summary       = %q{Transform text files into strings on a global JavaScript object.}
  spec.homepage      = "https://github.com/cloversites/js-text-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails", "~> 3.5"
end
