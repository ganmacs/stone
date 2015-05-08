module Stone
  module ArrayEvaluator
    def compute_assign(env, value)
      if left.is_a?(Stone::AST::Expression::Primary)
        if array_access?(left)
          ary = left.eval_sub_expression(env, 1)
          if ary.is_a?(Array)
            aref = left.postfix(0)
            index = aref.index.eval(env)
            ary[Integer(index)] = value
            return value
          end
          raise "Bad Assignment #{self}"
        end
      end
      super(env, value)
    rescue ArgumentError => e
      raise "bad Assigumnt #{e}"
    end

    def array_access?(left)
      left.has_postfix?(0) && left.postfix(0).is_a?(Stone::AST::ArrayRef)
    end
  end
end
