module Stone
  module Env
    class BasicEnv
      # name is `variable` name
      def []=(name, value)
        values.update(name => value)
      end
      alias_method :update, :[]=

      def [](name)
        values[name]
      end
      alias_method :get, :[]=

      private

      def values
        @values ||= {}
      end
    end
  end
end
