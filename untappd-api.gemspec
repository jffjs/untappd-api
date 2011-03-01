# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "untappd-api/version"

Gem::Specification.new do |s|
  s.name        = "untappd-api"
  s.version     = Untappd::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeff Smith"]
  s.email       = ["jffreyjs@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby wrapper for the untappd API.}
  s.description = %q{Ruby wrapper for the untappd API.}

  s.rubyforge_project = "untappd-api"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency %q<rspec>, ['~> 2.0.0.beta.22']
      s.add_dependency %q<httparty>, ['~> 0.7.4']
    else
      s.add_dependency %q<rspec>, ['~> 2.0.0.beta.22']
      s.add_dependency %q<httparty>, ['~> 0.7.4']
    end
  else
    s.add_dependency %q<rspec>, ['~> 2.0.0.beta.22']
    s.add_dependency %q<httparty>, ['~> 0.7.4']
  end
end
