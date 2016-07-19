class SimpleContestEvaluation < ContestEvaluation
  def evaluate!
    winners = simple_evaluate('winners')
    losers = simple_evaluate('losers')
    final_decision(winners, 'winner')
    # In the case where the winner is decided randomly,
    # ensure the same pet isn't also the loser
    losers = losers - [winner]
    final_decision(losers, 'loser')
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

  # Returns subset having greatest value for contest trait
  def simple_evaluate(result = 'winners')
    score_threshold = result == 'winners' ? 0 : 1/0.0
    comparator = result == 'winners' ? '>' : '<'
    subset = []
    contestants.each do |contestant|
      bp = BattlePet.find(contestant)
      trait_value = bp.trait_value(contest.battlepet_traits.first)
      if trait_value.public_send(comparator, score_threshold)
        score_threshold = trait_value
        subset = [bp.name]
      elsif trait_value == score_threshold
        subset.push(bp.name)
      end      
    end
    subset
  end

  # Assigns winner or loser instance variable
  # If the pet subset has only one item, this is the result
  # If the pet subset is longer than one item, the experience of the pets is evaluated
  #
  def final_decision(pet_subset, result = 'winner')
    if pet_subset.size() > 1
      most_or_least = result == 'winner' ? 'most' : 'least'
      instance_variable_set("@#{result}", evaluate_experience(pet_subset, most_or_least))
    elsif pet_subset.size() == 1
      instance_variable_set("@#{result}", pet_subset.first)
    end     
  end
end
