$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "common-content/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "common-content"
  s.version     = CommonContent::VERSION
  s.authors     = ["John Stewart"]
  s.email       = ["@john_s_in_co"]
  s.homepage    = "https://github.com/johnsinco/common-content"
  s.summary     = "Common-content is a simple CMS rails engine plugin for Mongoid based apps"
  s.description = "Common-content is a simple CMS rails engine plugin for Mongoid based apps"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.textile"]

  s.add_dependency "rails", "~> 3.2.1"
  # s.add_dependency "twitter-bootstrap-rails"
  # s.add_dependency "jquery-rails"

  s.add_dependency "RedCloth" 

  s.add_development_dependency "mongoid"
  s.add_development_dependency "rspec-rails"
  # s.add_development_dependency "bson_ext" 
  s.add_development_dependency "guard-rspec" 
  s.add_development_dependency "fuubar" 
end
