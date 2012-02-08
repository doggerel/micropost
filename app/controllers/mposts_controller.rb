class MpostsController < ApplicationController
  before_filter :authenticate, :only =>[:create,:destroy]
  before_filter :authorized_user, :only =>:destroy
  def create
    @mpost = current_user.mposts.build(params[:mpost])
    if @mpost.save
      flash[:success] = "Mpost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end
  def destroy
    @mpost.destroy
    redirect_back_or root_path
  end
  private
  def authorized_user
    @mpost = current_user.mposts.find_by_id(params[:id])
    redirect_to root_path if @mpost.nil?
  end
end
