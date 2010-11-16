# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "devise_paypal/version"

Gem::Specification.new do |s|
  s.name        = "devise_paypal"
  s.version     = DevisePaypal::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Wilkie"]
  s.email       = ["dwilkie@gmail.com"]
  s.homepage    = "http://github.com/dwilkie/devise_paypal"
  s.summary     = %q{Signup or login using Paypal}
  s.description = %q{Signup or login using Paypal's Authorization or Permissions api's}

  s.rubyforge_project = "devise_paypal"
  s.add_runtime_dependency "paypal-ipn", ">0.0.1"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

