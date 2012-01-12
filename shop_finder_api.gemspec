# coding: UTF-8
lib = File.expand_path('../lib', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "shop_finder_api/version"

Gem::Specification.new do |s|
  s.name        = "shop_finder_api"
  s.version     = ShopFinderApi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nozomu Kanechika"]
  s.email       = ["kanechika7@gmail.com"]
  s.homepage    = 'http://github.com/kanechika7/shop_finder_api'
  s.summary     = "Shopping Finder API"
  s.description = ""

  s.rubyforge_project = 'shop_finder_api'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README.md']
  s.require_paths = ['lib']

  #s.licenses = ['MIT']

  s.required_rubygems_version = ">= 1.3.6"
  s.add_dependency("rails",[">= 3.0.0"])
  s.add_dependency 'mongoid', ['>= 2']


  #s.add_dependency("strut",[":git => 'https://github.com/kuruma-gs/strut.git'"])
  #s.files        = Dir.glob("lib/**/*") + %W(README.md Rakefile)
  #s.require_paths = ['lib']
end

