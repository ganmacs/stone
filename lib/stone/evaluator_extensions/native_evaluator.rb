require 'stone/native_function'
module Stone
  module NativeEvaluator
    def eval(caller_env, function)
      if function.is_a?(Stone::NativeFunction)
        args = children.map { |c| c.eval(caller_env) }
        function.call(args, caller_env)
      else
        super(caller_env, function)
      end
    end
  end
end
