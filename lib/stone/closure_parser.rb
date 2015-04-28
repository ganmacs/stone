require 'stone/func_parser'

module Stone
  class ClosureParser < FuncParser
    def initialize
      super
      primary.insert_choice(closure)
    end

    # <closure> ::= "fun" <param_list> <block>
    def closure
      @closure ||= rule(Stone::AST::Fun).sep('fun').ast(param_list).ast(block)
    end
  end
end
