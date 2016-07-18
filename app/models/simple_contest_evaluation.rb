class SimpleContestEvaluation < ContestEvaluation
  def evaluate!
    winners = []
    @winner = nil
    losers = []
    @loser = nil
    high_score = 0
    low_score = 1/0.0
    contestants.each do |contestant|
      bp = BattlePet.find(contestant)
      trait_value = bp.trait_value(contest.battlepet_traits.first)
      if trait_value > high_score
        high_score = trait_value
        winners = [bp.name]
      elsif trait_value == high_score
        winners.push(bp.name)
      end

      if trait_value < low_score
        low_score = trait_value
        losers = [bp.name]
      elsif trait_value == low_score
        losers.push(bp.name)
      end
    end

    if winners.size() > 1 
      @winner = evaluate_experience(winners, 'most') 
    elsif winners.size() == 1
      @winner = winners.first
    end

    losers = losers - [winner]

    if losers.size() > 1
      @loser = evaluate_experience(losers, 'least')  
    elsif losers.size() == 1
      @loser = losers.first
    end    
  end

  def winner
    @winner ||= nil
  end

  def loser
    @loser ||= nil
  end

  private
  def contest
    @contest ||= nil
  end

  def contestants
    @contestants ||= nil
  end  
end
