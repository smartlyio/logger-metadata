# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logger/metadata/version'

Gem::Specification.new do |spec|
  spec.name          = "logger-metadata"
  spec.version       = Logger::Metadata::VERSION
  spec.authors       = ["Ville Lautanala"]
  spec.email         = ["lautis@gmail.com"]

  spec.summary       = %q{Metadata-aware Ruby Logger}
  spec.description   = %q{Enhance Ruby logger with support for key-value metadata.}
  spec.homepage      = "https://github.com/smartlyio/logger-metadata"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "actionpack"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
