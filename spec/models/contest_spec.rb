require 'rails_helper'

describe Contest, type: :model do
  let(:contest) { Contest.new(contest_type: 'wit') }
  
  describe 'attributes' do
    context 'with less than 2 battlepets' do
      it 'is invalid' do
        expect { contest.save! }.to raise_error(
          ActiveRecord::RecordInvalid,
          'Validation failed: Battlepets is too short (minimum is 2 characters)'
          )
      end
    end

    context 'without a type' do
      let(:contest) { Contest.new(battlepets: ['Totoro','Luna']) }

      it 'is invalid' do
        expect { contest.save! }.to raise_error(
          ActiveRecord::RecordInvalid,
          'Validation failed: Contest type can\'t be blank')
      end
    end
  end
end
