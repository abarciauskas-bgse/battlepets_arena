require 'rails_helper'

RSpec.describe "ContestResults", type: :request do
  describe "GET /contest_results" do
    it "works! (now write some real specs)" do
      get contest_results_path
      expect(response).to have_http_status(200)
    end
  end
end
