# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_component/version'

Gem::Specification.new do |spec|
  spec.name          = 'service_component'
  spec.version       = ServiceComponent::VERSION
  spec.authors       = ['Ernst van Graan']
  spec.email         = ['ernst.van.graan@hetzner.co.za']

  spec.summary       = %q{Service Component}
  spec.description   = %q{Service Component}
  spec.homepage      = 'https://github.com/hetznerZA/service_component'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'cucumber', '~> 2.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'rspec-expectations', '~> 3.3'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'soar_auditing_provider', '~> 0.7.0'
  spec.add_development_dependency 'soar_auditing_format', '~> 0.0.5'
  spec.add_development_dependency 'activesupport', '~> 5.0'
  spec.add_development_dependency 'rack', '~> 1.6.4'
  spec.add_development_dependency 'smaak', '~> 0.2.2'
  spec.add_development_dependency 'soar_smaak', '~> 0.1.16'

  #Requirements for running the manual script to publish services to the service registry
  spec.add_development_dependency 'soar_sr', '~> 1.1.22'
  spec.add_development_dependency 'persistent-cache', '~> 1.0.0'

  spec.add_dependency 'jsender'

end
