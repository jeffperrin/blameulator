$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "blameulator"
  s.version     = 0.1
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeff Perrin"]
  s.email       = ["jeffperrin@gmail.com"]
  s.homepage    = "http://github.com"
  s.summary     = "Creates a simple html changelog on a cvs repository"
  s.description = "Parse cvs rlog command to get a changelog showing all commits between two dates"

  s.rubyforge_project = "blameulator"

  s.files = %w[
    blameulator.gemspec
    lib/blameulator.rb
    lib/changelog_template.html.erb
  ]
  
  s.require_path = "lib"
end