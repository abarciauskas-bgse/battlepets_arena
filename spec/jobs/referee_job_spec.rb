require 'rails_helper'

RSpec.describe RefereeJob, type: :job do
  describe 'evaluate contest' do
    let(:referee) { RefereeJob.new() }
    let(:contest_type) { 'wit' }
    let(:contest) { Contest.create!(contest_type: contest_type, battlepets: ['Luna', 'Totoro']) }
    let(:luna_attributes) { [{attributes: {"name"=> contest_type, "value"=>25}}] }
    let(:luna) do
      mock('battlepet').dup do |pet|
        pet.stub(:traits) { luna_attributes }
      end
    end
    let(:totoro_attributes) { [{attributes: {"name"=> contest_type, "value"=>50}}] }
    let(:totoro) do
      mock('battlepet').dup do |pet|
        pet.stub(:traits) { totoro_attributes }
      end
    end
    before do
      BattlePet.stub(:find).with('Luna').and_return(luna)
      BattlePet.stub(:find).with('Totoro').and_return(totoro)
    end

    context 'when all contestants have a trait relating to the contest type' do
      context 'when one contestant has the highest value' do
        before { referee.evaluate_contest(contest.id) }
        let(:contest_result) { ContestResult.where(contest: contest).first }

        it 'is the winner' do
          expect(contest_result.winner).to eq('Totoro')
        end
        it 'the other contestant is the loser' do
          expect(contest_result.loser).to eq('Luna')
        end
      end
    end
  end
end
