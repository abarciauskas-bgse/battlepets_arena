require 'rails_helper'

RSpec.describe ContestResult, type: :model do
  let(:contest) { Contest.create!(contest_type: 'wit', battlepets: ['Luna', 'Totoro']) }
  let(:contest_result) { ContestResult.create!(winner: 'Luna', loser: 'Totoro', contest: contest) }
  
  describe 'attributes' do
    context 'with all required attributes' do
      it 'creates a new ContestResult' do
        expect { contest_result }.to change(ContestResult, :count).by(1)
      end
    end

    context 'without a winner or loser' do
      let(:contest_result) { ContestResult.create!(winner: 'Luna', contest: contest) }

      it 'is invalid' do
        expect { contest_result.save! }.to raise_error(
          ActiveRecord::RecordInvalid,
          'Validation failed: Loser can\'t be blank'
          )
      end
    end

    context 'without a contest' do
      let(:contest_result) { ContestResult.create!(winner: 'Luna', loser: 'Totoro') }

      it 'is invalid' do
        expect { contest_result.save! }.to raise_error(
          ActiveRecord::RecordInvalid,
          'Validation failed: Contest must exist, Contest can\'t be blank')
      end
    end
  end
end
