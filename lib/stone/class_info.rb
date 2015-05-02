module Stone
  class ClassInfo
    attr_reader :env

    def initialize(class_stament, env)
      @statement = class_stament
      @env = env
    end

    def name
      @statement.name
    end

    def super_class
      @super_class ||= @env[@statement.super_class]
    end

    def body
      @statement.body
    end

    def has_super_class?
      !!super_class
    end

    def to_s
      "<class #{name} >"
    end
  end
end
