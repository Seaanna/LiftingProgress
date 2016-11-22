class LiftsController < ApplicationController
  def index
    #assigning variable to all the Lifts in the db
    @lifts = Lift.all
  end
end
