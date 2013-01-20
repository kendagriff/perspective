module Perspective
  class Context
    def acts(*acts)
      actors.each { |actor| instance_variable_set("@#{actor}", nil) }
    end

    def self.actors(*actors)
      actors.each { |actor| instance_variable_set("@#{actor}", nil) }
    end

    def cast(actor, role)
      if actor.is_a?(Symbol)
        cast_as instance_variable_get("@#{actor}"), role
      else
        cast_as actor, role
      end
    end

    def initialize(actors={})
      stage
      actors.each { |actor| instance_variable_set("@#{actor[0]}", actor[1]) } if actors
    end

    def self.stage(&block)
      @stage = block if block_given?
      @stage
    end

    def stage
      instance_eval(&self.class.stage) if self.class.stage.is_a?(Proc)
    end

    def self.setup(&block)
      @setup = block if block_given?
      @setup
    end

    def setup
      instance_eval(&self.class.setup) if self.class.setup.is_a?(Proc)
    end

    # Allow class methods defined by the client
    # to be passed to an instance method, with setup
    def self.method_missing(name, *args, &block)
      if self.instance_methods(false).include?(name) 
        context = new(args[0])
        context.setup
        context.send(name)
      else
        super
      end
    end

    def self.respond_to?(name)
      if self.instance_methods(false).include?(name)
        true
      else
        super
      end
    end

    private

    def cast_as(actor, role)
      actor.extend role
    end
  end
end
