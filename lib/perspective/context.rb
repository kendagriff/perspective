module Perspective
  class Context
    def acts(*acts)
      actors.each { |actor| instance_variable_set("@#{actor}", nil) }
    end

    def self.actors(*actors)
      actors.each { |actor| instance_variable_set("@#{actor}", nil) }
    end

    def cast(actor, role)
      instance_variable_get("@#{actor}").extend role
    end

    def initialize(actors={})
      actors.each { |actor| instance_variable_set("@#{actor[0]}", actor[1]) }
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
  end
end
