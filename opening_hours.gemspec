# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opening_hours/version'

Gem::Specification.new do |spec|
  spec.name          = "opening_hours"
  spec.version       = OpeningHours::VERSION
  spec.authors       = ["Ian Whitney"]
  spec.email         = ["whit0694@umn.edu"]
  spec.summary       = %q{Parser for the OpeningHours schema from schema.org.}
  spec.description   = %q{Library that parses date ranges in the openingHours format https://schema.org/openingHours.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
