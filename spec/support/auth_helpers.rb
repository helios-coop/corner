# frozen_string_literal: true

module AuthHelpers
  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end

  def current_user
    User.find(session[:user_id])
  end
end
