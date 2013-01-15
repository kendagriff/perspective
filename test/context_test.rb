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

  class ApplyForJob < Context
    actors :interviewer, :interviewee

    setup do
      cast :interviewer, AngryAttitude
      cast :interviewee, HumbleAttitude
    end

    def call
      @interviewer.speak
      @interviewee.speak
    end
  end

  class ContextTest < ActiveSupport::TestCase
    test "set up context" do
      interviewer = mock
      interviewer.expects(:speak).returns("Are you any good?!?")
      interviewee = mock
      interviewee.expects(:speak).returns("Yes, sir, I am.")
      ApplyForJob.call(interviewer: interviewer, interviewee: interviewee)
    end
  end
end
