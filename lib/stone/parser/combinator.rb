require 'stone/parser/ast_builder'
require 'stone/parser/element'

module Stone
  module Parser
    module Helper
      def rule(klass = nil)
        Parser::Combinator.new(klass)
      end
    end

    class Combinator
      attr_reader :builder, :elements

      def initialize(klass)
        return reset if klass.nil?

        if klass.new([]).respond_to?(:elements) # parser(combinator) 微妙
          @elements = klass.elements
          @builder = parser.builder
        else
          reset(klass)
        end
      end

      def parse(lexer)
        results = []
        @elements.each do |elem|
          elem.parse(lexer, results) # @TODO return result value
        end
        @builder.build(results)
      end

      def match?(lexer)
        if @elements.size == 0
          true
        else
          @elements[0].match?(lexer)
        end
      end

      def reset(klass = nil)
        @elements = []
        @builder = ASTBuilder.ast_list(klass)
        self
      end

      # @subexp Parser
      def expression(subexp, operator, klass = nil)
        @elements << Element::Expression.new(klass, subexp, operator)
        self
      end

      def or(*parser)
        @elements << Element::OrTree.new(*parser)
        self
      end

      def identifier(reserved, klass = nil)
        @elements << Element::Id.new(klass, reserved)
        self
      end

      def ast(parser)
        @elements << Element::Tree.new(parser)
        self
      end

      def sep(*pattern)
        @elements << Element::Skip.new(pattern)
        self
      end

      def number(klass = nil)
        @elements << Element::Number.new(klass)
        self
      end

      def string(klass = nil)
        @elements << Element::String.new(klass)
        self
      end

      def repeat(parser)
        @elements << Element::Repeat.new(parser)
        self
      end

      def option(parser)
        @elements << Element::Repeat.new(parser, once: true)
        self
      end
    end
  end
end
