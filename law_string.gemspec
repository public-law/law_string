# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'law_string'
  spec.version       = '1.2.3'
  spec.authors       = ['Robb Shecter']
  spec.email         = ['robb@public.law']

  spec.summary       = 'String Utils including a specialized #titleize.'
  spec.description   = 'A set of utils narrowly written to support Public.Law. Focus on reducing object instantation at the cost of readability.'
  spec.homepage      = 'https://github.com/public-law/law_string'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
