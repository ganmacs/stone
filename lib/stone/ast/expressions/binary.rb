require 'stone/ast/list'

module Stone
  module AST
    module Expression
      class Binary < List
        def initialize(children)
          super(children)
        end

        def left
          child(0)
        end

        def right
          child(2)
        end

        def operator
          child(1).token.text
        end
      end
    end
  end
end
