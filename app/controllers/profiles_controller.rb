class ProfilesController < ApplicationController
  before_action :user_params, only: :full_profile_edit

  def full_profile
    @user = current_user
  end

  def show
  end

  def full_profile_edit
    @user = User.find(current_user.id)
    @user.assign_attributes(user_params)
    @weight = Weight.create(value: params[:user][:weight][:value])
    @user.weights << @weight
    if @user.save
      redirect_to profiles_path
    else
      render :full_profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:height, :phone, :birthday, :gender, :photo)
  end
end
