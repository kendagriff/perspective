require File.expand_path('../../lib/perspective', __FILE__)
require 'turn'
require 'pry'
require 'active_support/test_case'

class ActiveSupport::TestCase
  Turn.config.format = :dot
end
