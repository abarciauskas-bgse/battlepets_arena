class ContestResultsController < ApplicationController
  before_action :set_contest_result, only: [:show, :update, :destroy]

  # GET /contest_results
  def index
    @contest_results = ContestResult.all

    render json: @contest_results
  end

  # GET /contest_results/1
  def show
    render json: @contest_result
  end

  # POST /contest_results
  def create
    @contest_result = ContestResult.new(contest_result_params)

    if @contest_result.save
      render json: @contest_result, status: :created, location: @contest_result
    else
      render json: @contest_result.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contest_results/1
  def update
    if @contest_result.update(contest_result_params)
      render json: @contest_result
    else
      render json: @contest_result.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contest_results/1
  def destroy
    @contest_result.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest_result
      @contest_result = ContestResult.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contest_result_params
      params["params"].require(:contest_result).permit(:winner, :loser, :contest_id)
    end
end
