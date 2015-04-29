require 'stone/asts/postfix'

module Stone
  module AST
    class Arguments < Postfix
      alias_method :size, :number_of_children
    end
  end
end
