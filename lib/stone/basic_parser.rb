require 'set'
require 'stone/extender'
require 'stone/parser_extensions/func_parser'
require 'stone/parser_extensions/class_parser'
require 'stone/parser_extensions/array_parser'
require 'stone/parser_extensions/let_biding_parser'
require 'stone/parser/combinator'
require 'stone/parser/operators'
require 'stone/token'
require 'stone/ast'

module Stone
  class BasicParser
    include Parser
    include Parser::Helper
    prepend FuncParser
    prepend ClassParser
    prepend ArrayParser
    prepend LetBindingParser
    include Extender

    REVERVED = [';', '}', Token::EOL].freeze
    OPERATORS = [['=',  1, Operators::RIGHT],
                 ['==', 2, Operators::LEFT],
                 ['>',  2, Operators::LEFT],
                 ['<',  2, Operators::LEFT],
                 ['+',  3, Operators::LEFT],
                 ['-',  3, Operators::LEFT],
                 ['*',  4, Operators::LEFT],
                 ['/',  4, Operators::LEFT],
                 ['%',  4, Operators::LEFT]].freeze

    def initialize
      setup_reserved
      setup_operators
    end

    def parse(lexer)
      program.parse(lexer)
    end

    private

    def expr0
      @rule ||= rule
    end

    # <primary> := "(" <expr> ")" | NUM | IDEN | STR
    def primary
      @primary ||= rule(Stone::AST::Expression::Primary).or(rule.sep('(').ast(expr0).sep(')'),
                                                            rule.number(Stone::AST::Literal::Number),
                                                            rule.identifier(reserved, Stone::AST::Name),
                                                            rule.string(Stone::AST::Literal::String))
    end

    # <factor> := "-" <primary> | <primary>
    def factor
      @factor ||= rule.or(
        rule(Stone::AST::Expression::Negative).sep('-').ast(primary),
        primary)
    end

    def expression
      @expression ||= expr0.expression(factor, operators, Stone::AST::Expression::Binary)
    end

    def statement0
      @statement0 ||= rule
    end

    def block
      @block ||= rule(Stone::AST::Statement::Block)
      @block ||= begin
        rule(Stone::AST::Statement::Block)
        .sep('{').option(statement0)
        .repeat(rule.sep(';', Token::EOL).option(statement0))
        .sep('}')
      end
    end

    def simple
      @simple ||= rule(Stone::AST::Expression::Primary).ast(expression)
    end

    def statement
      @statement ||= statement0.or(
        rule(Stone::AST::Statement::If).sep('if').ast(expression).ast(block).option(rule.sep('else').ast(block)),
        rule(Stone::AST::Statement::While).sep('while').ast(expression).ast(block),
        simple
      )
    end

    def program
      @program ||= rule.or(statement, rule).sep(';', Token::EOL)
    end

    def setup_operators
      OPERATORS.each do |operator|
        operators.add(*operator)
      end
    end

    def setup_reserved
      REVERVED.each do |id|
        reserved.add(id)
      end
    end

    def reserved
      @reserved ||= Set.new
    end

    def operators
      @operators ||= Stone::Parser::Operators.new
    end
  end
end
