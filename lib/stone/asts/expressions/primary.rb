require 'stone/asts/list'

module Stone
  module AST
    module Expression
      class Primary < List
        def operand
          children[0]
        end

        def postfix(nest)
          children[number_of_children - nest - 1]
        end

        def has_postfix?(nest)
          number_of_children - nest > 1
        end

        class << self
          # override initializer
          # if has a only child, not create duplicate PrimaryExpr
          def new(c)
            c.size == 1 ? c[0] : super(c)
          end
        end
      end
    end
  end
end
