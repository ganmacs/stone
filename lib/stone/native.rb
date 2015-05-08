require 'stone/native_function'

module Stone
  class Native
    class << self
      def environment
        Native.new.build
      end
    end

    def build
      { 'let' => build_function(:_let),
        'add' => build_function(:_add) }
    end

    private

    def build_function(name)
      NativeFunction.new(name.to_s, method(name))
    end

    def _let(name, proc, env)
      env[name] = NativeFunction.new(name,  eval(proc))
      nil                       # return value
    end

    def _add(a, b)
      a + b
    end

    def env
      @env ||= {}
    end
  end
end
