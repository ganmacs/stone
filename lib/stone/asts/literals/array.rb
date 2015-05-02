require 'stone/asts/leaf'

module Stone
  module AST
    module Literal
      class Array < List
        alias_method :size, :number_of_children

        def eval(env)
          children.map { |c| c.eval(env) }
        end
      end
    end
  end
end
