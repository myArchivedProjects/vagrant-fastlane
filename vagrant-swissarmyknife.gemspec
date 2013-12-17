# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant/swissarmyknife/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-swissarmyknife"
  spec.version       = Vagrant::Swissarmyknife::VERSION
  spec.authors       = ["Azul"]
  spec.email         = ["dontspam@azulinho.com"]
  spec.description   = %q{swissarmyknife for vagrant}
  spec.summary       = %q{simplifies tasks for vagrant}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "lib/vagrantswissarmyknife"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "commander"
  #
  spec.add_runtime_dependency "bundler", "~> 1.3"
  spec.add_runtime_dependency "commander"
  #
end
