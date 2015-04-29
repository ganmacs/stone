require 'stone/asts/list'

module Stone
  module AST
    module Statement
      class If < List
        def condition
          child(0)
        end

        def then_block
          child(1)
        end

        def else_block
          child(2) if has_else_block?
        end

        def to_s
          "(if #{condition} #{then_block}".tap do |s|
            s << "else #{else_block}" if has_else_block?
            s << ')'
          end
        end

        private

        def has_else_block?
          number_of_children > 2
        end
      end
    end
  end
end
