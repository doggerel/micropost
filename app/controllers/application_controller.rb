class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
   def avatar_url(user,size=48)
     unless user.nil?
       default_url = "#{root_url}images/guest.png"  
        gravatar_id = Digest::MD5::hexdigest(user.email).downcase  
        view_context.image_tag "http://gravatar.com/avatar/#{gravatar_id}.png?d=identicon&s=#{size}"  
     else
       return "no user"
     end
  end
   helper_method :avatar_url
   helper_method :external_link
end
