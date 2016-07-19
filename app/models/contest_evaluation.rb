class ContestEvaluation
  def initialize(contest)
    @contest = contest
    @contestants = contest.battlepets
  end

  # Evaluates set of pets with pet names as least or most experienced,
  # dependent on the `by` argument
  def evaluate_experience(pet_subset, by = 'least')
    experienced = compare_experience(pet_subset, by)
    least_or_most = nil
 
    if experienced.size() == 1
      least_or_most = experienced.first
    else
      least_or_most = experienced.sample
    end
    least_or_most
  end

  private
  # Returns array of pet_subset having the most or least experience
  # Array of length one if there is a unique maximum
  # 
  def compare_experience(pet_subset, by = 'least')
    experience_threshold = 0
    experienced = []
    pet_subset.each do |name|
      pet_experience = BattlePet.experience(name)
      comparator = by == 'most' ? '>' : '<'
      if pet_experience.public_send(comparator.to_sym, experience_threshold)
        experienced = [name]
        experience_threshold = pet_experience
      elsif pet_experience == experience_threshold
        experienced.push(name)
      end
    end
    experienced
  end
end
