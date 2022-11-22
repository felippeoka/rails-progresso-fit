class WeightsController < ApplicationController
  def new
    @weight = Weight.new
  end

  def create
    @weight = Weight.new(weight_params)
    @weight.user = current_user
    if @weight.save
      redirect_to weight_path(@weight)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @weight = Weight.find(params[:id])
  end

  def destroy
    @weight = Weight.find(params[:id])
    @weight.destroy
    redirect_to profiles_path, status: :see_other
  end

  private

  def weight_params
    params.require(:weight).permit(:value, photos: [])
  end
end
