require 'stone/ast'

module Stone
  module NativeParser
    def initialize
      super
      program.insert_choice(let)
    end

    # <let> ::= "let" "(" IDEN "," <closure> ")"
    def let
      @let ||= rule(Stone::AST::Let).sep('let').sep('(').ast(let_args).sep(')')
    end

    def let_args
      @aaa ||= rule(Stone::AST::ParameterList).identifier(reserved).sep(',').ast(closure)
    end
  end
end
