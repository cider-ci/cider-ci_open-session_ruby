# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cider_ci/open_session/version'

Gem::Specification.new do |spec|
  spec.name          = 'cider_ci-open_session'
  spec.version       = CiderCi::OpenSession::VERSION
  spec.authors       = ['Thomas Schank']
  spec.email         = ['DrTom@schank.ch']

  spec.summary       = 'Platform and language agnostic encoding,' \
                        ' encryption and signatures for session handling.'
  spec.homepage      = 'https://github.com/cider-ci/cider-ci_open-session_rails'
  spec.license       = 'AGPL'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'simplecov'

end
