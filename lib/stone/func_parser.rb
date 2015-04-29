require 'stone/basic_parser'
require 'stone/ast'

module Stone
  class FuncParser < BasicParser
    def initialize
      super
      reserved.add(')')
      primary.repeat(postfix)
      simple.option(args)
      program.insert_choice(defn)
      primary.insert_choice(closure)
    end

    def param
      rule.identifier(reserved)
    end

    # <params> ::= <param> { "," <params> }
    def params
      @params ||= rule(Stone::AST::ParameterList).ast(param).repeat(rule.sep(',').ast(param))
    end

    # <param_list> ::= "(" [ params ] ")"
    def param_list
      @params_lsit ||= rule.sep('(').maybe(params).sep(')')
    end

    # <defn> ::= "defn" IDENTIFIER <param_list> <block>
    def defn
      @defn ||= rule(Stone::AST::Statement::Defn).sep('defn').identifier(reserved).ast(param_list).ast(block)
    end

    def args
      @args ||= rule(Stone::AST::Arguments).ast(expression).repeat(rule.sep(',').ast(expression))
    end

    def postfix
      @postfix ||= rule.sep('(').maybe(args).sep(')')
    end

    # <closure> ::= "fun" <param_list> <block>
    def closure
      @closure ||= rule(Stone::AST::Fun).sep('fun').ast(param_list).ast(block)
    end
  end
end
