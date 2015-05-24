require 'stone/asts/leaf'

module Stone
  module AST
    class Name < Leaf
      def name
        token.text
      end

      def eval(env)
        if env['let_op'].nil?
          env[name]
        elsif env['let_op'][name]
          env['let_op'][name]
        else
          env[name]
        end or raise "Undefined Name: #{self}"
      end
    end
  end
end
