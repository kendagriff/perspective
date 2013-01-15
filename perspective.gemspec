$:.push File.expand_path("../lib", __FILE__)
require 'perspective/version'

Gem::Specification.new do |s|
  s.name        = 'perspective'
  s.version     = Perspective::VERSION
  s.date        = '2013-01-15'
  s.summary     = "DCI in Ruby"
  s.description = "DCI implementation in Ruby"
  s.authors     = ["Kendall Buchanan"]
  s.email       = 'kendall@teachbanzai.com'
  s.files       = Dir.glob("lib/**/*")
  s.require_path = 'lib'
  s.homepage    = 'https://github.com/kendagriff/perspective'
end
