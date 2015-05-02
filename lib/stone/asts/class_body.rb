require 'stone/asts/base'

module Stone
  module AST
    class ClassBody < List
      def eval(env)
        children.each do |c|
          c.eval(env)
        end
        nil
      end
    end
  end
end
