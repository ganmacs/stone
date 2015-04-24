module Stone
  module Parser
    module Element
      class Base
        def parse(_, _)
          raise NotImplementedError
        end

        def match?(_)
          raise NotImplementedError
        end
      end
    end
  end
end
