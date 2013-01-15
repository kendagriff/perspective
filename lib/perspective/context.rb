module Perspective
  class Context
    def self.actors(*actors)
      actors.each { |actor| instance_variable_set("@#{actor}", nil) }
    end

    def self.setup
      yield
    end

    def self.cast(actor, role)
      instance_variable_get("@#{actor}").extend role
    end

    def initialize(actors={})
      actors.each { |actor| instance_variable_set("@#{actor[0]}", actor[1]) }
    end

    def self.call(actors={})
      new(actors).call
    end
  end
end
