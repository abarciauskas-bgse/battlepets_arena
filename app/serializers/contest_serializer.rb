class ContestSerializer < ActiveModel::Serializer
  attributes :battlepets, :contest_type, :battlepet_traits, :_result, :_self

  def _result
    result = ContestResult.where(contest: self.object).first
    if result
      BASE_URL + "contest_results/#{result.id}"
    else
      ''
    end
  end

  def _self
    BASE_URL + "contests/#{self.object.id}"
  end
end
