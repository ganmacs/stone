require 'stone/env'

# function object
module Stone
  class Function
    attr_reader :parameters, :body

    def initialize(parameters, body, env)
      @parameters = parameters
      @body = body
      @env = env
    end

    def make_env
      Stone::Env.new(@env)
    end

    def to_s
      "<fun: #{self}>"
    end
  end
end
