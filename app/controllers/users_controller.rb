require 'passwordchecker'
class UsersController < ApplicationController
  include PasswordChecker
  before_filter :authenticate, :only =>[:index, :edit,:update,:destroy]
  before_filter :correct_user, :only =>[:edit,:update]
  before_filter :admin, :only => :destroy
  before_filter :signed_in_user, :only =>[:new, :create]
  #before_filter :no_admin_delete, :only =>[:destroy]

  def index 
    @title = "All users"
    @users = User.paginate(:page =>params[:page])
  end
  def destroy
    user = User.find(params[:id])
    if user.admin? and current_user?(user)
      flash[:info] = "admin user can't delete themselves. Why would you want to?"
      redirect_to users_path
    else
      user.destroy
      flash[:success] = "User destroyed"
      redirect_to users_path
    end

  end
  def show
    @user = User.find(params[:id])
    @mposts = @user.mposts.paginate(:page=>params[:page])
    @title = @user.name
  end
  def new
    @title = "Sign up"
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    chk = Checker.new(params[:user][:password])
    @password_strength = chk.password_strength
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Micropost app"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "{@user.name.view_context.humanize} Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  private
  def signed_in_user
    redirect_to(root_path) unless !signed_in?
  end
  def admin
    redirect_to(root_path) unless current_user.admin?
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  def no_admin_delete
    user = User.find(params[:id])
    redirect_to(root_path) if user.admin? and current_user?(user)

    
  end
end
