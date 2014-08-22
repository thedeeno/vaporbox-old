# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vaporbox/version'

Gem::Specification.new do |spec|
  spec.name          = "vaporbox"
  spec.version       = Vaporbox::VERSION
  spec.authors       = ["Dane O'Connor"]
  spec.email         = ["dane.oconnor@gmail.com"]
  spec.summary       = %q{Ruby bidnings for guerrillamail.com (temp email service)}
  spec.description   = %q{Do true mail integration tests with this library}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
