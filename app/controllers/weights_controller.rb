class WeightsController < ApplicationController
  def new
    @weight = Weight.new
  end

  def create
    @weight = Weight.new(weight_params)
    @weight.user = current_user
    if @weight.save
      redirect_to users_show_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def weight_params
    params.require(:weight).permit(:weight, :user_id)
  end
end
