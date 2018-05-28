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
      SlackNotifier.new.call(:new_user, user: @user)

      redirect_to listings_path
    else
      render :new
    end
  end

  # Contact Us Page
  def contact; end

  # Recieves message from Contact Us page
  def message
    if SlackNotifier.new.call(:contact_us, params: params)
      flash[:success] = "We've notified a real person. " \
                      "Hodl tight and we'll get back to you."
    else
      flash[:danger] = "Something has gone horribly wrong. " \
                      "You're message was not sent. " \
                      "We'd say to get a hold of us through the contact form, "\
                      "but........."
    end

    redirect_to contact_path
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
