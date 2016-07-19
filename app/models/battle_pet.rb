class BattlePet < ActiveResource::Base
  self.site = BATTLEPETS_MANAGEMENT_URL

  def trait_value(pet_trait)
    self.traits.collect(&:attributes).select{|trait| trait['name'] == pet_trait}.first['value']
  end

  def self.experience(battle_pet_name)
    experience = 0
    experience += experience_of_type(battle_pet_name, 'winner')
    experience += experience_of_type(battle_pet_name, 'loser')
    experience
  end

  def self.experience_of_type(battle_pet_name, result = 'winner')
    added_experience = 0
    if result == 'winner'
      results = ContestResult.where(winner: battle_pet_name)
      added_experience = results.size()*EXPERIENCE_FOR_WIN
    elsif result == 'loser'
      results = ContestResult.where(loser: battle_pet_name)
      added_experience = results.size()*EXPERIENCE_FOR_LOSS     
    end
    added_experience
  end
end
