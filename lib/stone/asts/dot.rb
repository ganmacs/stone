require 'stone/asts/postfix'
require 'stone/class_info'
require 'stone/stone_object'

module Stone
  module AST
    class Dot < Postfix
      def name
        children[0].token.text
      end

      def to_s
        ".#{name}"
      end

      def eval(env, receiver)
        if receiver.is_a?(Stone::ClassInfo)
          if init_method?
            e = Env.new(receiver.env)
            so = Stone::StoneObject.new(e)
            env.update_new('this', so)
            init_object(receiver, e)
            so
          end
        elsif receiver.respond_to?(:read) # StoneObject
          receiver.read(name)
        else
          raise "Bad Member : #{name}"
        end
      end

      private

      def init_object(class_info, env)
        init_object(class_info.super_class, env) if class_info.has_super_class?
        class_info.body.eval(env)
      end

      def init_method?
        name == 'new'
      end
    end
  end
end
