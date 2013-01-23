# Perspective

Providing an attractive DSL for implementing DCI in Ruby.

## Usage

```ruby
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

    def no_interview
      true
    end

    def interviewer_name
      @interviewer
    end
  end
```
