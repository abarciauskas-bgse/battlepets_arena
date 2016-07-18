require 'rails_helper'

describe BattlePet, type: :model do
  let(:hamtaro_name) { 'Hamtaro' }
  let(:totoro_name)  { 'Totoro' }
  let(:luna_name)    { 'Luna' }

  before :each do
    c1 = Contest.create!(contest_type: 'competitive eating', battlepets: [hamtaro_name, totoro_name])
    ContestResult.create!(contest: c1, winner: hamtaro_name, loser: totoro_name)
  end

  describe '.experience' do
    context 'with a win' do
      it 'is the experience for a win' do
        experience = BattlePet.experience(hamtaro_name)
        expect(experience).to eq(EXPERIENCE_FOR_WIN)
      end
    end

    context 'with a loss' do
      it 'is the experience for a loss' do
        experience = BattlePet.experience(totoro_name)
        expect(experience).to eq(EXPERIENCE_FOR_LOSS)
      end
    end 

    context 'with no experience' do
      it 'is zero' do
        experience = BattlePet.experience(luna_name)
        expect(experience).to eq(0)
      end
    end        
  end
end
