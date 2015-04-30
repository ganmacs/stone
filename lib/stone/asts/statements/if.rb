require 'stone/asts/list'

module Stone
  module AST
    module Statement
      class If < List
        def condition
          children[0]
        end

        def then_block
          children[1]
        end

        def else_block
          children[2] if has_else_block?
        end

        def to_s
          "(if #{condition} #{then_block}".tap do |s|
            s << "else #{else_block}" if has_else_block?
            s << ')'
          end
        end

        def eval(env)
          cond = condition.eval(env)
          if cond.is_a?(Fixnum) && cond != FALSE
            then_block.eval(env)
          else
            if has_else_block?
              else_block.elva(env)
            else
              0
            end
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
