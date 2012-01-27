class SessionsController < ApplicationController
  def new
    @user = User.new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                            params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination"
      @title = "Sign in"
      render "new"
    else
      remember_me = params[:session][:remember]
      sign_in(user, remember_me)
      redirect_to user
      
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
