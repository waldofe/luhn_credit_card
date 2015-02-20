lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "luhn_credit_card"
  spec.version       = '0.0.2'
  spec.authors       = ["Oswaldo Ferreira"]
  spec.email         = ["oswluizf@gmail.com"]
  spec.summary       = %q{Credit card validations using Luhn Algorithm.}
  spec.description   = %q{It's a simple tool that provides helper methods for credit card number validations using Luhn Algorithm.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency 'rspec', '~> 3.1', '>= 3.1.0'
  spec.add_development_dependency 'simplecov', '~> 0.9'
end
