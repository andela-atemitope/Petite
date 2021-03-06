# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "petite/version"

Gem::Specification.new do |spec|
  spec.name          = "petite"
  spec.version       = Petite::VERSION
  spec.authors       = ["Amodu Temitope"]
  spec.email         = ["amodut@gmail.com"]

  spec.summary       = "Petite MVC Framework"
  spec.description   = "Petite Framework"
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail "RubyGems 2.0 or newer is required to
          protect against public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  #
  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "tilt", "1.4.1"
  spec.add_runtime_dependency "sqlite3"
  spec.add_runtime_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "bigdecimal"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter"
end
