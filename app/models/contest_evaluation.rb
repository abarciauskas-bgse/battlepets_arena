class ContestEvaluation
  def initialize(contest)
    @contest = contest
    @contestants = contest.battlepets
  end

  def evaluate_experience(pet_names, by = 'least')
    experience_threshold = 0
    experienced = []
    least_or_most = nil

    pet_names.each do |name|
      pet_experience = BattlePet.experience(name)
      if by == 'most' && pet_experience > experience_threshold
        experienced = [name]
        experience_threshold = pet_experience
      elsif by == 'least' && pet_experience < experience_threshold
        experienced = [name]
        experience_threshold = pet_experience
      elsif pet_experience == experience_threshold
        experienced.push(name)
      end
    end
 
    if experienced.size() == 1
      least_or_most = experienced.first
    else
      least_or_most = experienced.sample
    end
    least_or_most
  end
end
