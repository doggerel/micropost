class MpostsController < ApplicationController
  before_filter :authenticate, :only =>[:create,:destroy]
  def create
    @mpost = current_user.mposts.build(params[:mpost])
    if @mpost.save
      flash[:success] = "Mpost created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
  def destroy
  end
end
