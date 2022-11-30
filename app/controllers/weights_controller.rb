class WeightsController < ApplicationController

  def index
    if params.present?
      # @weights = Weight.where(:created_at ==  params[:search][:created_at])
      # sql_query = "value ILIKE :query OR created_at ILIKE :query"
      # @weight = Weight.where(sql_query, query: "%#{params[:query]}%")
      # @weights = Weight.where('DATE(created_at) = ?', params[:query])
      @weights = Weight.search_by_value_and_created_at(value: params[:query])
    else
      @weights = Weight.all
    end
  end

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
