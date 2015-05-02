require 'stone/ast'
require 'stone/token'

module Stone
  module ArrayParser
    def initialize
      super
      reserved.add(']')
      primary.insert_choice(ary)
      postfix.insert_choice(ary_postfix)
    end

    # <elements> ::= <expsression> { "," <expsression> }
    def elements
      rule(Stone::AST::Literal::Array).ast(expression).repeat(rule.sep(',').ast(expression))
    end

    # <array> ::= "[" [ <elements> ] "]"
    def ary
      @ary ||= rule.sep('[').maybe(elements).sep(']')
    end

    # <ary_postfix> ::= "[" <expression> "]"
    def ary_postfix
      rule(Stone::AST::ArrayRef).sep('[').ast(expression).sep(']')
    end
  end
end
