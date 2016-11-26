class LiftsController < ApplicationController
  def create
    # defining new create method
    @lift = Lift.new(lift_params)

    if @lift.save
      render json: @lift
    else
      render json: @lift.errors, status: :unprocessable_entity
    end
  end

  def index
    #assigning variable to all the Lifts in the db
    @lifts = Lift.all
  end

  private
  # using strong params to whitelist data
  def lift_params
    params.require(:lift).permit(:date, :liftname, :ismetric, :weightlifted, :repsperformed, :onerm)
  end
end
