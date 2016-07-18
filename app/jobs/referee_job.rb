class RefereeJob < ActiveJob::Base
  queue_as :default

  def perform(contest_id)
    evaluate_contest(contest_id)
  end

  def evaluate_contest(contest_id)
    contest = Contest.find(contest_id)
    contest_type = contest.contest_type
    contestants = contest.battlepets
    winners = []
    winner = nil
    losers = []
    loser = nil
    high_score = 0
    low_score = 1/0.0
    contestants.each do |contestant|
      bp = BattlePet.find(contestant)
      trait_value = bp.trait_value(contest_type)
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
      winner = evaluate_experience(winners, 'most') 
    elsif winners.size() == 1
      winner = winners.first
    end

    losers = losers - [winner]

    if losers.size() > 1
      loser = evaluate_experience(losers, 'least')  
    elsif losers.size() == 1
      loser = losers.first
    end

    ContestResult.create!(contest: contest, winner: winner, loser: losers.first)
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
