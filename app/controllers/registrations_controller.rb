class RegistrationsController < Devise::RegistrationsController
  
    def destroy
    	f = Fish.find current_user.fish_id
    	f.destroy
    	File.delete("public/#{current_user.image}")
  		resource.destroy
		set_flash_message :notice, :destroyed
		sign_out_and_redirect(resource)
  	end
  protected

	def after_sign_up_path_for(resource)
		
    	"/profile/show/#{current_user.id}"
 	end

end
