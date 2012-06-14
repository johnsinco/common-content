$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "common-content/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "common-content"
  s.version     = CommonContent::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CommonContent."
  s.description = "TODO: Description of CommonContent."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.1"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "mongoid"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "bson_ext" 
end
