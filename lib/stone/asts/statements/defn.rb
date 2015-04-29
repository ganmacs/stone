require 'stone/asts/list'

module Stone
  module AST
    module Statement
      class Defn < List
        def name
          child(0).token.text
        end

        def prameters
          child(1)
        end

        def body
          child(2)
        end

        def to_s
          "(defn #{name} #{prameters} #{body})"
        end
      end
    end
  end
end
