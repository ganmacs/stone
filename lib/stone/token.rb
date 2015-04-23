require 'stone/tokens/base'
require 'stone/tokens/id'
require 'stone/tokens/num'
require 'stone/tokens/str'

module Stone
  module Token
    EOL = "\n"
    EOF = Base.new(-1)
  end
end
