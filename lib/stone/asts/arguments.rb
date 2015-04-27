require 'stone/asts/postfix'

module Stone
  module AST
    class Arguments < Postfix
      def initialize(children)
        super(children)
      end

      alias_method :size, :number_of_children
    end
  end
end
