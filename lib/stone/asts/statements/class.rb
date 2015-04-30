module Stone
  module AST
    module Statement
      class Class < List              # name is...
        def name
          children[0].token.text
        end

        def super_class
          children[1].token.text if has_super_class?
        end

        def body
          children[-1]
        end

        def to_s
          "(class #{name} #{super_class || '*'} #{body})"
        end

        private

        def has_super_class?
          number_of_children >= 3
        end
      end
    end
  end
end
