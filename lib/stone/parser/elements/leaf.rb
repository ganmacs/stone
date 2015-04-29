require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class Leaf < Base
        def initialize(patterns)
          @tokens = patterns
        end

        # @result - [AST::Tree] parsed tree
        def parse(lexer)
          token = lexer.read_token
          if token.id?
            token_str = @tokens.find { |t| t == token.text }
            raise "parse exception #{token}" if token_str.nil?
            find(token)
          end
        end

        def find(token)
          Stone::AST::Leaf.new(token)
        end

        def match?(lexer)
          token = lexer.peek_token
          !!@tokens.find { |t| t == token.text }
        end
      end
    end
  end
end
