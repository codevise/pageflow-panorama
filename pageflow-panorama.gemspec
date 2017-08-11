# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pageflow/panorama/version'

Gem::Specification.new do |spec|
  spec.name          = 'pageflow-panorama'
  spec.version       = Pageflow::Panorama::VERSION
  spec.authors       = ['Codevise Solutions']
  spec.email         = ['info@codevise.de']
  spec.summary       = 'Pagetype for iframe embedded 360° panoramas'
  spec.homepage      = 'https://github.com/codevise/pageflow-panorama'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.1'

  spec.add_runtime_dependency 'pageflow', ['>= 0.11', '< 13']
  spec.add_runtime_dependency 'state_machine_job', ['>= 0.2', '< 2']
  spec.add_runtime_dependency 'rubyzip', '~> 1.1'
  spec.add_runtime_dependency 'pageflow-public-i18n', '~> 1.0'

  spec.add_development_dependency 'pageflow-support', ['>= 0.11.4', '< 13']
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'factory_girl_rails', '~> 4.5'
  spec.add_development_dependency 'mysql2', '~> 0.3.21'

  # Semantic versioning rake tasks
  spec.add_development_dependency 'semmy', '~> 1.0'
end
