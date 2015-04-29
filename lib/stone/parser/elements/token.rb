require 'stone/parser/elements/base'
require 'stone/parser/ast_builder'

module Stone
  module Parser
    module Element
      class Token < Base
        def initialize(type)
          type ||= Stone::AST::Leaf
          @builder = ASTBuilder.build(type)
        end

        def parse(lexer)
          token = lexer.read_token
          @builder.call(token) if test(token)
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
