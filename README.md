# Perspective

Providing an attractive DSL for implementing DCI in Ruby.

## Usage

```ruby
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
    @interviewer.speak
    @interviewee.speak
  end
end

ApplyForJob.interview(interviewer: Person.new, interviewee: Person.new)
```
