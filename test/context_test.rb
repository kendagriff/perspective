require 'test_helper'

module Perspective
  module AngryAttitude
    def speak
      puts "Are you any good?!?"
    end
  end

  module HumbleAttitude
    def speak
      puts "Yes, sir, I am."
    end
  end

  module VeryHumbleAttitude
    def speak
      super
      puts "Yes, yes, yes, sir, I am."
    end
  end

  class ApplyForJob < Context
    actors :interviewer, :interviewee

    setup do
      cast :interviewer, AngryAttitude
      cast :interviewee, HumbleAttitude
    end

    def interview
      cast @interviewee, VeryHumbleAttitude
      @interviewer.speak
      @interviewee.speak
    end
  end

  class ContextTest < ActiveSupport::TestCase
    test "set up context" do
      STDOUT.expects(:puts).times(3)
      ApplyForJob.interview(interviewer: mock, interviewee: mock)
    end
  end
end
