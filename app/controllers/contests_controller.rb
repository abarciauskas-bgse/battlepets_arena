class ContestsController < ApplicationController
  # POST /contests
  def create
    @contest = Contest.new(contest_params)

    if @contest.save
      render json: @contest, status: :created, location: @contest
    else
      render json: @contest.errors, status: :unprocessable_entity
    end
  end

  private
  # Only allow a trusted parameter "white list" through.
  def contest_params
    params.require(:contest).permit(:contest_type, :battlepets => [])
  end
end
