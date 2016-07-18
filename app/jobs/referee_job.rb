class RefereeJob < ActiveJob::Base
  queue_as :default

  def perform(contest_id)
    evaluate_contest(contest_id)
  end

  def evaluate_contest(contest_id)
    contest = Contest.find(contest_id)
    contest_type = contest.contest_type
    @evaluation = nil
    if contest_type == 'simple'
      @evaluation = SimpleContestEvaluation.new(contest)
      @evaluation.evaluate!
    end
    ContestResult.create!(contest: contest, winner: @evaluation.winner, loser: @evaluation.loser)
  end
end
