class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :except => "Index#index" 
  
  	def after_sign_in_path_for(resource)
    	"/profile/show/#{current_user.id}"
	end
end
