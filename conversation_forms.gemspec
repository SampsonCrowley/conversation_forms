$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "conversation_forms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "conversation_forms"
  s.version     = ConversationForms::VERSION
  s.authors     = ["Sampson Crowley"]
  s.email       = ["sampsonsprojects@gmail.com"]
  s.homepage    = "https://github.com/SampsonCrowley/conversation_forms"
  s.summary     = "Create the ultimate form."
  s.description = "conversation_forms allows you to create a form that runs as a chat conversation for the ultimate user experience"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_development_dependency "sqlite3"
end
