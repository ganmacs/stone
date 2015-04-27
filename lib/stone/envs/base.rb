module Stone
  module Env
    class Base
      # name is `variable` name
      def []=(name, value)
        values.update(name => value)
      end
      alias_method :update, :[]=

      def [](name)
        values[name]
      end
      alias_method :get, :[]

      def where(name)
      end

      def update_new(name, value)
      end

      def outer_env=(env)
      end

      private

      def values
        @values ||= {}
      end
    end
  end
end
