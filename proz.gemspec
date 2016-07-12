# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proz/version'

Gem::Specification.new do |spec|
  spec.name          = "proz"
  spec.version       = Proz::VERSION
  spec.authors       = ["Kevin S. Dias"]
  spec.email         = ["diasks2@gmail.com"]
  spec.summary       = %q{Ruby wrapper for the ProZ.com API}
  spec.description   = %q{A Ruby wrapper for working with the ProZ.com 2.0 API, a REST-like API for interacting with ProZ.com services.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rspec", "3.4.0"
  spec.add_runtime_dependency "httparty"
  spec.add_runtime_dependency "oauth2"
end
