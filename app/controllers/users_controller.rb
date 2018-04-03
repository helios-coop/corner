# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Much Wow. Account created"
      redirect_to listings_path
    else
      render :new
    end
  end

  private

  PERMITTED_PARAMS = [
    :display_name,
    :email,
    :password,
    :password_confirmation,
  ].freeze

  def user_params
    params.require(:user).permit(*PERMITTED_PARAMS).merge(role: "user")
  end
end
