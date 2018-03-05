# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if invalid_password_length?
      # This should only happen if the user is removing html input validations.
      flash[:danger] = "Roger V says: Don't Do That!"
      render :new
    elsif @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Much Wow. Account created'
      redirect_to listings_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
  end

  def invalid_password_length?
    user_params[:password].length < 8
  end
end
