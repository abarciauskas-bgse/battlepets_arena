class ContestSerializer < ActiveModel::Serializer
  attributes :battlepets, :contest_type, :battlepet_traits, :_result, :_self

  def _result
    result = ContestResult.where(contest: self.object).first
    BASE_URL + "contest_results/#{result.id}"
  end

  def _self
    BASE_URL + "contests/#{self.object.id}"
  end
end
