module Perspective
  class Context
    def self.actors(*actors)
      actors.each { |actor| instance_variable_set("@#{actor}", nil) }
    end

    def cast(actor, role)
      instance_variable_get("@#{actor}").extend role
    end

    def initialize(actors={})
      actors.each { |actor| instance_variable_set("@#{actor[0]}", actor[1]) }
      setup
    end

    def self.setup(&block)
      @setup = block if block_given?
      @setup
    end

    def setup
      instance_eval(&self.class.setup) if self.class.setup.is_a?(Proc)
    end

    def self.call(actors={})
      new(actors).call
    end
  end
end
