class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:id] = @user.id
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
end
