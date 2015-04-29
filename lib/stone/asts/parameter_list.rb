require 'stone/asts/list'

module Stone
  module AST
    class ParameterList < List
      def name(i)
        children[i].token.text
      end

      alias_method :size, :number_of_children
    end
  end
end
