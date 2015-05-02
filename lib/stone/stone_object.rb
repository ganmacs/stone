require 'stone/env'

module Stone
  class StoneObject
    def initialize(env)
      @env = env
    end

    def read(method)
      env(method)[method]
    end

    def write(method, value)
      env(method).update_new(method, value)
    end

    def env(method)
      e = @env.find_env(method)
      return e if !e.nil? && e != @env
      raise NameError           # specic error
    end

    def to_s
      "<object #{object_id}>"   # object_id is unique id
    end
  end
end
