require 'rails_helper'

RSpec.describe ContestsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Contest. As you add validations to Contest, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {battlepet_traits: ["wit"], :battlepets => ["Totoro", "Luna"]} }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Contest" do
        expect {
          post :create, params: {contest: valid_attributes}
        }.to change(Contest, :count).by(1)
      end

      it "assigns a newly created contest as @contest" do
        post :create, params: {contest: valid_attributes}
        expect(assigns(:contest)).to be_a(Contest)
        expect(assigns(:contest)).to be_persisted
      end

      it "redirects to the created contest" do
        post :create, params: {contest: valid_attributes}
        expect(response).to be_success
      end

      it "enqueues a contest object" do
        expect(RefereeJob).to receive(:perform_later)
        post :create, params: {contest: valid_attributes}
      end     
    end
  end
end
