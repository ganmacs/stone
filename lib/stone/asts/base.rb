module Stone
  module AST
    class Base
      # def child(i)
      #   raise NotImplementedError
      # end

      def number_of_children
        raise NotImplementedError
      end

      def children
        raise NotImplementedError
      end

      def location
        raise NotImplementedError
      end

      def iterator
        children
      end
    end
  end
end
