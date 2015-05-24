require 'stone/ast'

module Stone
  module LetBindingParser
    def initialize
      super
      program.insert_choice(let)
      program.insert_choice(let_op)
    end

    # <let> ::= "let" "(" IDEN "," <closure> ")"
    def let
      @let ||= rule(Stone::AST::Let).sep('let').sep('(').ast(let_args).sep(')')
    end

    def let_op
      @let_op ||= rule(Stone::AST::LetOp).sep('let_op').sep('(').ast(inner).sep(')')
    end

    def inner
      @inner ||= rule(Stone::AST::ParameterList).ast(ary).sep(',').ast(block)
    end

    def let_args
      @aaa ||= rule(Stone::AST::ParameterList).identifier(reserved).sep(',').ast(closure)
    end
  end
end
