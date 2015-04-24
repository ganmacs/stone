require 'stone/parser/elements/base'
require 'stone/parser/ast_builder'

module Stone
  module Parser
    module Element
      class Token < Base
        def initialize(type)
          type ||= Stone::AST::Leaf
          @factory = ASTBuilder.get(type)
        end

        def parse(lexer, result)
          token = lexer.read_token
          if test(token)
            leaf = @factory.build(token)
            result << leaf      # ast::leaf
          end
        end

        def match?(lexer)
          test(lexer.peek_token)
        end

        def test
          raise NotImplementedError
        end
      end
    end
  end
end
