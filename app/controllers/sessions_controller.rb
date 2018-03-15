class SessionsController < ApplicationController
  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      true
    else
      false
    end
  end
end
