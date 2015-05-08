require 'stone/native'

module Stone
  class Env
    def initialize(env = nil)
      @outer = env
    end

    def outer_env=(env)
      @outer = env
    end

    # @name is `variable` name
    def [](name)
      values[name] || (@outer && @outer[name])
    end
    alias_method :get, :[]

    def []=(name, value)
      env = find_env(name)
      env.update_new(name, value)
    end
    alias_method :update, :[]=

    def update_new(name, value)
      values[name] = value
    end

    def find_env(name)
      if exist?(name)
        self
      else
        has_outer? ? @outer.find_env(name) : self
      end
    end

    def extend(*envs)
      envs.each do |e|
        values.update(e)
      end
      self
    end

    private

    def has_outer?
      !!@outer
    end

    def exist?(name)
      !!values[name]
    end

    def values
      @values ||= {}
    end
  end
end
