require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class Expression < Base
        # @exp Parser class
        def initialize(klass, exp, ops)
          @builder = ASTBuilder.build(klass)
          @operators = ops
          @factor = exp
        end

        def parse(lexer)
          right = @factor.parse(lexer)
          while prec = next_opertor(lexer)
            right = shift(lexer, right, prec.value)
          end
          right
        end

        def match?(lexer)
          @factor.match?(lexer)
        end

        def shift(lexer, left, prec)
          list = [left]
          list << Stone::AST::Leaf.new(lexer.read_token) # get operator
          right = @factor.parse(lexer)
          while (next_prec = next_opertor(lexer)) && right_is_expression?(prec, next_prec)
            right = shift(lexer, right, next_prec.value)
          end
          list << right
          @builder.call(list)
        end

        def next_opertor(lexer)
          token = lexer.peek_token
          @operators.operators[token.text] if token.id?
        end

        # 引数の方が微妙
        def right_is_expression?(prec, next_prec)
          if next_prec.left_associative?
            prec < next_prec.value
          else
            prec <= next_prec.value
          end
        end
      end
    end
  end
end
