require 'stone/ast/list'

module Stone
  module AST
    module Expression
      class Primary < List
        def initialize(tree)
          super(tree)
        end

        # if has a child, not create duplicate PrimaryExpr
        def create(c)
          c.size == 1 ? c[0] : PrimaryExpr.new(c)
        end
      end
    end
  end
end
