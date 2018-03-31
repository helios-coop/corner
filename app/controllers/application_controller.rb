# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    return if current_user

    flash[:danger] = "You must be logged in to do that."
    redirect_to login_path
  end

  def authorize_admin
    return if current_user&.role == "admin"

    flash[:danger] = "You must be and Admin to do that."
    redirect_to root_path
  end
end
