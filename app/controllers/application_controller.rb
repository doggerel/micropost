class ApplicationController < ActionController::Base
  protect_from_forgery
   def avatar_url(user,size=48)
    default_url = "#{root_url}images/guest.png"  
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase  
    view_context.image_tag "http://gravatar.com/avatar/#{gravatar_id}.png?d=identicon&s=#{size}"  
  end
   helper_method :avatar_url
end
