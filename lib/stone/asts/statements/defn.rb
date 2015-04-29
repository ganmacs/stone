require 'stone/asts/list'

module Stone
  module AST
    module Statement
      class Defn < List
        def name
          children[0].token.text
        end

        def prameters
          children[1]
        end

        def body
          children[2]
        end

        def to_s
          "(defn #{name} #{prameters} #{body})"
        end
      end
    end
  end
end
