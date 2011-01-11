# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "abstract_auth/version"

Gem::Specification.new do |s|
  s.name        = "abstract_auth"
  s.version     = AbstractAuth::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Cook"]
  s.email       = ["ryan@quickleft.com"]
  s.homepage    = "https://github.com/cookrn/abstract_auth"
  s.summary     = %q{A gem to safely provide external application resources with a coherent and configurable API to a host application's authentication procedures.}
  s.description = %q{A gem to safely provide external application resources with a coherent and configurable API to a host application's authentication procedures.}

  s.rubyforge_project = "abstract_auth"

  s.add_dependency "module_ext", "~> 0.1.0"
  s.add_development_dependency "rake", "~> 0.8.7"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
