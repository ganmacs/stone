require 'stone/asts/leaf'

module Stone
  module AST
    class Name < Leaf
      def name
        token.text
      end

      def eval(env)
        env[name] or raise "Undefined Name: #{self}"
      end
    end
  end
end
