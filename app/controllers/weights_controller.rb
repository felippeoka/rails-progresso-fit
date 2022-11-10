class WeightsController < ApplicationController
  def new
    @weight = Weight.new
  end
  
  def create
    @weight = Weight.new(weight_params)
    @weight.user = current_user
  end


end
