class ContestsController < ApplicationController
  # GET /contests/1
  def show
    set_contest
    render json: @contest
  end

  # POST /contests
  def create
    @contest = Contest.new(contest_params)

    if @contest.save
      RefereeJob.perform_later(@contest.id)
      binding.pry
      render json: @contest, status: :created, location: @contest
    else
      render json: @contest.errors, status: :unprocessable_entity
    end
  end

  private

  def set_contest
    @contest = Contest.find(params[:id])
  end  
  # Only allow a trusted parameter "white list" through.
  def contest_params
    params["params"].require(:contest).permit(:contest_type, :battlepet_traits => [], :battlepets => [])
  end
end
