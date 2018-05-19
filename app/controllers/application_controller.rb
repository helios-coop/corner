# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: proc { |c| c.request.format == "application/json" }
  helper_method :current_user
  helper_method :google_maps_api_key

  before_action :fake_ip unless Rails.env.production?
  before_action :detect_device_variant
  before_action :set_google_analytics_key if Rails.env.production?

  private

  def fake_ip
    request.headers["REMOTE_ADDR"] = ENV.fetch("REMOTE_ADDR")
  end

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

  # http://blog.chrismaxwell.com/mobile-device-detection-with-ruby-on-rails
  def detect_device_variant
    return unless browser.device.mobile?
    request.variant = :phone
    prepend_view_path Rails.root.join("app", "views", "mobile_views")
  end

  def google_maps_api_key
    ENV.fetch("GOOGLE_MAPS_API_KEY")
  end

  def set_google_analytics_key
    gon.google_analytics_key = ENV.fetch("GOOGLE_ANALYTICS_KEY")
  end
end
