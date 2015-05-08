module Stone
  class NativeFunction
    # @body Proc
    def initialize(name, body)
      @name = name
      @body = body
    end

    def call(args, env = nil)
      if @name == '_let'
        @body.call(*args, env)
      else
        @body.call(*args)
      end
    end

    def to_s
      "<native: #{object_id} >"
    end
  end
end
