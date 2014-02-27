# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auphonic/version'

Gem::Specification.new do |spec|
  spec.name          = "auphonic"
  spec.version       = Auphonic::VERSION
  spec.authors       = ["Phil Hofmann"]
  spec.email         = ["phil@branch14.org"]
  spec.description   = %q{A ruby wrapper and CLI for the Auphonic API.}
  spec.summary       = %q{A ruby wrapper and CLI for the Auphonic API.}
  spec.homepage      = "https://github.com/branch14/auphonic"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 1.3"
  # spec.add_development_dependency "thor"
  # spec.add_development_dependency "rspec"
end
