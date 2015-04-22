require 'stone/ast/list'

module Stone
  module AST
    module Statement
      class If < List
        def initialize(children)
          super(children)
        end

        def condtion
          child(0)
        end

        def then_block
          child(1)
        end

        def else_block
          child(2) if has_else?
        end

        def to_s
          "(if #{condtion} #{then_block}".tap do |s|
            s << "else #{else_block}" if has_else_block?
            s << ')'
          end
        end

        private

        def has_else_black?
          number_of_children > 2
        end
      end
    end
  end
end
