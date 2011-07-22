class RegistrationsController < Devise::RegistrationsController
  protected

	def after_sign_up_path_for(resource)
		
    	"/profile/show/#{current_user.id}"
 	end

end
