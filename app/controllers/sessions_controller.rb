# Authenticaiton was created following this doc: https://gist.github.com/thebucknerlife/10090014

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      flash[:success] = 'Great, your logged in. Now when Lambo?'
      session[:user_id] = user.id
      redirect_to listings_path
    else
      flash[:danger] = 'Couldn\'t log in. Looks like you got Rekt.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Bye bye boys. Have fun storming the castle.'
    redirect_to listings_path
  end
end
