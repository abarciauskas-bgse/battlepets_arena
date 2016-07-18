class BattlePet < ActiveResource::Base
  self.site = "http://localhost:3000/"

  def trait_value(trait)
    self.traits.collect(&:attributes).select{|trait| trait['name'] == contest_type}.first['value']
  end

  def self.experience(battle_pet_name)
    experience = 0
    winners = ContestResult.where(winner: battle_pet_name)
    losers = ContestResult.where(loser: battle_pet_name)
    experience += winners.size()*EXPERIENCE_FOR_WIN
    experience += losers.size()*EXPERIENCE_FOR_LOSS
    experience
  end
end
