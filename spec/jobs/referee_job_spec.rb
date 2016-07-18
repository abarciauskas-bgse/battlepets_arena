require 'rails_helper'

RSpec.describe RefereeJob, type: :job do
  describe 'evaluate contest' do
    let(:referee) { RefereeJob.new() }
    let(:contest_type) { 'wit' }
    let(:luna_trait_value) { 25 }
    let(:luna) { double('battlepet') }
    let(:totoro_trait_value) { 50 }
    let(:totoro) { double('battlepet') }
    let(:contest) { Contest.create!(contest_type: contest_type, battlepets: ['Luna', 'Totoro']) }
    let(:contest_result) { ContestResult.where(contest: contest).last }
    before do
      expect(luna).to receive(:trait_value).with(contest_type).and_return(luna_trait_value)
      expect(luna).to receive(:name).and_return('Luna').at_least(:once)
      expect(totoro).to receive(:trait_value).with(contest_type).and_return(totoro_trait_value)
      expect(totoro).to receive(:name).and_return('Totoro').at_least(:once)
      expect(BattlePet).to receive(:find).with('Luna').and_return(luna)
      expect(BattlePet).to receive(:find).with('Totoro').and_return(totoro)
    end

    context 'when all contestants have a trait relating to the contest type' do
      before { referee.evaluate_contest(contest.id) }
      
      context 'when one contestant has the highest value' do
        it 'is the winner' do
          expect(contest_result.winner).to eq('Totoro')
        end
        it 'the other contestant is the loser' do
          expect(contest_result.loser).to eq('Luna')
        end
      end
    end

    context 'when contestants have the same level of the trait' do
      let(:luna_trait_value) { 50 }

      context 'when neither has more experience' do
        before { referee.evaluate_contest(contest.id) }

        it 'still returns a winner' do
          expect(contest_result.winner).not_to be_nil
        end

        it 'still returns a loser' do
          expect(contest_result.loser).not_to be_nil
        end

        # FIXME: Flaky test
        it 'has a different winner and loser' do
          expect(contest_result.loser).not_to eq(contest_result.winner)
        end
      end

      context 'when one has more experience' do
        before :each do
          c = Contest.create!(contest_type: 'strength', battlepets: ['Hamtaro', 'Totoro'])
          ContestResult.create!(contest: c, loser: 'Totoro', winner: 'Hamtaro')
          referee.evaluate_contest(contest.id)
        end

        it 'they are the winner' do
          expect(contest_result.loser).to eq('Luna')
        end
      end
    end
  end
end
