class WeightsController < ApplicationController
  before_action :set_weight, only: %i[show edit update destroy]

  def index
    if params[:begin].present? && params[:end].present?
      # @weights = current_user.weights.search_by_value_and_created_at(params[:query])
      date_begin = Date.parse(params[:begin])
      date_end = Date.parse(params[:end])
      if date_begin > date_end
        flash[:alert] = "End date have to be greater than beginning date."
        redirect_to weights_path
      end
      @weights = current_user.weights.where("created_at BETWEEN ? AND ?", date_begin.beginning_of_day, date_end.end_of_day)
    elsif params[:begin].present?
      date_begin = Date.parse(params[:begin])
      @weights = current_user.weights.where("created_at >= ? ", date_begin.beginning_of_day)
    elsif params[:end].present?
      date_end = Date.parse(params[:end])
      @weights = current_user.weights.where("created_at <= ? ", date_end.end_of_day)
    else
      @weights = current_user.weights
    end
  end

  # def index
  #   if params.present?
      # @weights = Weight.where(:created_at ==  params[:search][:created_at])
      # sql_query = "value ILIKE :query OR created_at ILIKE :query"
      # @weight = Weight.where(sql_query, query: "%#{params[:query]}%")
      # @weights = Weight.where('DATE(created_at) = ?', params[:query])
      # @weights = Weight.search_by_value_and_created_at(value: params[:query])
  #   else
  #     @weights = Weight.all
  #   end
  # end
  def email_notification
    if User.weights.last&.value.where("created_at >= ?", 1.week.ago.utc)
      EmailNotificationMailer.with(weight: @weight).post_new_weight.deliver_later
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
  end

  def edit
  end

  def update
    if @weight.update(weight_params)
      redirect_to weight_path(@weight)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @weight.destroy
    redirect_to profiles_path, status: :see_other
  end

  private

  def weight_params
    params.require(:weight).permit(:value, photos: [])
  end

  def set_weight
    @weight = Weight.find(params[:id])
  end
end
