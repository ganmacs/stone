require 'stone/envs/base'

module Stone
  module Env
    class NestedEnv < Base
      def initialize(env = nil)
        @outer = env
      end

      def outer_env=(env)
        @outer = env
      end

      def [](name)
        values[name] || (@outer && @outer[name])
      end

      def []=(name, value)
        env = where(name) || self
        env.update_new(name, value)
      end

      def update_new(name, value)
        values[name] = value
      end

      def where(name)
        return self if values[name]
        @outer && @outer.where(name)
      end
    end
  end
end
