require 'stone/asts/list'

module Stone
  module AST
    module Statement
      class Block < List
        def eval(env)
          children.map { |c| c.eval(env) }.last # each?
        end
      end
    end
  end
end
