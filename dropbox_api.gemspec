# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dropbox_api/version'

Gem::Specification.new do |spec|
  spec.name          = "dropbox_api"
  spec.version       = DropboxApi::VERSION
  spec.authors       = ["Jesús Burgos"]
  spec.email         = ["jburmac@gmail.com"]

  spec.summary       = "Library for communicating with Dropbox API v2"
  spec.homepage      = "https://github.com/Jesus/dropbox_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "faraday"
  spec.add_dependency "oauth2", "~> 1.1"
end
