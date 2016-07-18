class RefereeJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    evaluate_contest(*args)
  end

  #private

  def evaluate_contest(args = {})
    contest = Contest.find(args[:contest_id])
    contest_type = contest.contest_type
    contestants = contest.battlepets
    winners = []
    winner = nil
    loser = nil
    high_score = 0
    low_score = 100000000000
    contestants.each do |contestant|
      bp = BattlePet.find(contestant)
      trait_value = bp.traits.collect(&:attributes).select{|trait| trait['name'] == contest_type}.first['value']
      if trait_value > high_score
        winners = [bp.name]
      elsif trait_value == high_score
        winners.push(bp.name)
      end

      if trait_value <= low_score
        low_score = low_score
        loser = bp.name
      end
    end

    if winners.size() > 1
      # evaluate experience
    elsif winners.size() == 1
      winner = winners.first
    end

    ContestResult.create!(contest: contest, winner: winner, loser: loser)
  end
end
