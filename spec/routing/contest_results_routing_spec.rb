require "rails_helper"

RSpec.describe ContestResultsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/contest_results").to route_to("contest_results#index")
    end

    it "routes to #new" do
      expect(:get => "/contest_results/new").to route_to("contest_results#new")
    end

    it "routes to #show" do
      expect(:get => "/contest_results/1").to route_to("contest_results#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/contest_results/1/edit").to route_to("contest_results#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/contest_results").to route_to("contest_results#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/contest_results/1").to route_to("contest_results#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/contest_results/1").to route_to("contest_results#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/contest_results/1").to route_to("contest_results#destroy", :id => "1")
    end

  end
end
