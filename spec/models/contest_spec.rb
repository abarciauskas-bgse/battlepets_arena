
require 'rails_helper'

describe Contest, type: :model do
  let(:contest) { Contest.new(battlepet_traits: ['wit']) }
  
  describe 'attributes' do
    context 'with less than 2 battlepets' do
      it 'is invalid' do
        expect { contest.save! }.to raise_error(
          ActiveRecord::RecordInvalid,
          'Validation failed: Battlepets are too short (minimum is 2)'
          )
      end
    end

    context 'without a contest type' do
      let(:contest) { Contest.new(battlepets: ['Totoro','Luna'], battlepet_traits: ['wit']) }

      it 'has a default' do
        contest.save!
        expect(contest.contest_type).to eq('simple')
      end
    end

    context 'with invalid contest type' do
      let(:contest) do
        Contest.new(
          battlepets: ['Totoro','Luna'],
          battlepet_traits: ['wit'],
          contest_type: 'shuffleboard')
      end

      it 'is invalid' do
        expect { contest.save! }.to raise_error(
          ActiveRecord::RecordInvalid,
          'Validation failed: Contest type is not included in the list'
          )          
      end      
    end

    context 'with wrong number of traits' do
      let(:contest) { Contest.new(battlepet_traits: [], battlepets: ['Totoro','Luna']) }

      context 'with less than minimum' do
        it 'is invalid' do
          expect { contest.save! }.to raise_error(
            ActiveRecord::RecordInvalid,
            'Validation failed: Battlepet traits are too long or too short (maximum is 1, minimum is 1)'
            )          
        end
      end

      context 'with more than maximum' do
        let(:contest) { Contest.new(battlepet_traits: ['wit','spunk'], battlepets: ['Totoro','Luna']) }

        it 'is invalid' do
          expect { contest.save! }.to raise_error(
            ActiveRecord::RecordInvalid,
            'Validation failed: Battlepet traits are too long or too short (maximum is 1, minimum is 1)'
            )          
        end
      end      
    end
  end
end
