class ContestResultSerializer < ActiveModel::Serializer
  attributes :winner, :loser, :_contest, :_self

  def _contest
    BASE_URL + "contests/#{self.object.contest.id}"
  end

  def _self
    BASE_URL + "contests/#{self.object.id}"
  end  
end
