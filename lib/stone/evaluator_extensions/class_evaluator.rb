module ClassEvaluator
  def compute_assign(env, value)
    if left.is_a?(Stone::AST::Expression::Primary)
      if method_call?(left)
        ret = left.eval_sub_expression(env, 1)
        return set_field(ret, left.postfix(0), value) if ret.is_a?(Stone::StoneObject)
      end
    end
    super(env, value)
  end

  def method_call?(left)
    left.has_postfix?(0) && left.postfix(0).is_a?(Stone::AST::Dot)
  end
end
