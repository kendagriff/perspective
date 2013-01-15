# Perspective

Providing an attractive DSL for implementing DCI in Ruby.

## Usage

```
# Roles
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

# Context
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
```
