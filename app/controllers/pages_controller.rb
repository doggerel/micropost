class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @mpost = Mpost.new 
      @feed_items = current_user.feed.paginate(:page =>params[:page])
    end
  end
  def contact
    @title = "Contact"
  end
  def about
    @title = "About"
  end
  def help
    @title = "Help"
  end

end
