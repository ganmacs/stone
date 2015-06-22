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
        if klass.respond_to?(:elements)
          @elements = klass.elements
          @builder = klass.builder
        else
          reset(klass)
        end
      end

      def parse(lexer)
        results = @elements.flat_map { |e| e.parse(lexer) }.compact
        @builder.call(results)
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
        @builder ||= ASTBuilder.build(klass)
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

      def maybe(parser)
        p2 = Parser::Combinator.new(parser).reset
        @elements << Element::OrTree.new(parser, p2)
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

      def insert_choice(parser)
        e = @elements.first
        if e.is_a?(Element::OrTree)
          e.insert(parser)
        else
          other = Combinator.new(self)
          reset
          self.or(parser, other)
        end
        self
      end
    end
  end
end
