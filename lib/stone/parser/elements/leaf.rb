require 'stone/parser/elements/base'

module Stone
  module Parser
    module Element
      class Leaf < Base
        def initialize(patterns)
          @tokens = patterns
        end

        # @result - [AST::Tree] parsed tree
        def parse(lexer, results)
          token = lexer.read_token
          if token.id?
            token_str = @tokens.find { |t| t == token.text }
            raise " parse excetpion #{token}" if token_str.nil?
            return find(results, token)
          end
        end

        def find(results, token)
          results << Stone::AST::Leaf.new(token)
        end

        def match?(lexer)
          token = lexer.peek_token
          !!@tokens.find { |t| t == token.text }
        end
      end
    end
  end
end
