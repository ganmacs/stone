require 'stone/asts/list'

module Stone
  module AST
    module Expression
      class Primary < List
        def initialize(tree)
          super(tree)
        end

        def operand
          child(0)
        end

        def postfix(nest)
          child(number_of_children - nest - 1)
        end

        def has_postfix?(nest)
          number_of_children - nest > 1
        end

        # if has a only child, not create duplicate PrimaryExpr
        class << self
          def create(c)
            c.size == 1 ? c[0] : Primary.new(c)
          end
        end
      end
    end
  end
end
