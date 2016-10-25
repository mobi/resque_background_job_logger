# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resque_background_job_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'resque_background_job_logger'
  spec.version       = ResqueBackgroundJobLogger::VERSION
  spec.authors       = ["MOBI Wireless Management"]
  spec.email         = ['gems@mobiwm.com']

  spec.summary       = %q{Adds tracking of resque jobs through an ActiveRecord model}
  spec.description   = %q{Allows resque jobs to be tracked with a database table. Includes additional information about the job including arguments, time started, ended, and memory stats.}
  spec.homepage      = 'https://github.com/mobi/resque_background_job_logger'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'rails', '>= 4.0'
  spec.add_dependency 'resque', '>= 1.25.0', '< 2'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'resque-status'
end
