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

    stage do
      @interviewer = "Jimmy Page"
    end

    setup do
      cast :interviewer, AngryAttitude
      cast :interviewee, HumbleAttitude
    end

    def interview
      cast @interviewee, VeryHumbleAttitude
      @interviewer.speak
      @interviewee.speak
    end

    def interviewer_name
      @interviewer
    end
  end

  class ApplyForJobInAnotherSetting < Context
    actors :interviewer, :interviewee

    def no_interview
      true
    end

    def interview
      @interviewer.speak
    end
  end

  class ContextTest < ActiveSupport::TestCase
    test "set up context" do
      STDOUT.expects(:puts).times(3)
      ApplyForJob.interview(interviewer: mock, interviewee: mock)
    end

    test "respond to" do
      assert ApplyForJob.respond_to?(:interview)
    end

    test "no actor provided" do
      assert ApplyForJobInAnotherSetting.no_interview
    end

    test "stage" do
      assert_equal 'Jimmy Page', ApplyForJob.interviewer_name(interviewee: mock)
    end
    
    test "cannot cast nil actor" do
      assert_raise ContextError do
        ApplyForJob.interview("Some string")
      end
    end
    
    test "throws exception for missing actor" do
      assert_raise ContextError do
        ApplyForJobInAnotherSetting.interview("Some string")
      end
    end
  end
end
