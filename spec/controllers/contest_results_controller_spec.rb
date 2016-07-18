require 'rails_helper'

RSpec.describe ContestResultsController, type: :controller do
  let(:contest) { Contest.create!(battlepets: ['Luna', 'Totoro'], battlepet_traits: ['wit']) }
  # This should return the minimal set of attributes required to create a valid
  # ContestResult. As you add validations to ContestResult, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {contest_id: contest.id, winner: "Luna", loser: "Totoro"}
  }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ContestResult" do
        expect {
          post :create, params: {contest_result: valid_attributes}
        }.to change(ContestResult, :count).by(1)
      end

      it "assigns a newly created contest_result as @contest_result" do
        post :create, params: {contest_result: valid_attributes}
        expect(assigns(:contest_result)).to be_a(ContestResult)
        expect(assigns(:contest_result)).to be_persisted
      end

      it "redirects to the created contest_result" do
        post :create, params: {contest_result: valid_attributes}
        expect(response).to be_success
      end
    end
  end
end
