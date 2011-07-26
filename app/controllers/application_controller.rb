class ApplicationController < ActionController::Base
	before_filter :authenticate_user!, :except => "Index#index"

  protect_from_forgery
  
  
  	def after_sign_in_path_for(resource)
    	"/profile/show/#{current_user.id}"
	end
end
