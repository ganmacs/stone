require 'stone/asts/base'

module Stone
  module AST
    class List < Base
      attr_reader :children

      def initialize(children)
        raise "should array not #{children}" unless children.is_a?(Array)
        @children = children
      end

      def number_of_children
        children.size
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
