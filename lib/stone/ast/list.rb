require 'stone/ast/base'

module Stone
  module AST
    class List < Base
      def initialize(children)
        @children = children
      end

      def child(i)
        children[i]
      end

      def number_of_children
        children.size
      end

      def children
        @children
      end

      def to_s
        '(%s)' % children.map(&:to_s).join(' ')
      end

      def location
        children.map(&:location).find(&:itself)
      end
    end
  end
end
