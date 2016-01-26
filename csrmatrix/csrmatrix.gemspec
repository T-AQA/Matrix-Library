# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csrmatrix/version'

Gem::Specification.new do |spec|
  spec.name          = "csrmatrix"
  spec.version       = CsrMatrix::VERSION
  spec.authors       = ["Anson Li, Quentin Lautischer, Aaron Plamondon"]
  spec.email         = ["hello@teamaqua.ca"]

  spec.summary       = %q{Efficient sparse matrix library.}
  spec.description   = %q{Generation of a sparse matrix package in order to satisfy: 1. Reusability - insofar that the system can be reused for different structures; 2. Efficiency - in both storage and runtime; 3. Light - we need lightweight process stuctures in order to reduce overhead to a minimum.}
  spec.homepage      = "https://github.com/Team-Aqua/Matrix-Library/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
