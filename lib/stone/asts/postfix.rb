require 'stone/asts/list'

module Stone
  module AST
    class Postfix < List
      def initialize(children)
        super(children)
      end
    end
  end
end
