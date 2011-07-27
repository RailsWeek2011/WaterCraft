class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :except => [:index, :info] 
  
  	def after_sign_in_path_for(resource)
    	"/profile/show/#{current_user.id}"
	end
	
	def getRaceStat i
		case i
			when 0
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 1
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 2
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 3
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 4
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 5
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 6
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 7
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 8
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 9
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 10
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 11
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 12
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 13
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 14
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			when 15
				return { :str => 2, :dev => 3, :con => 2, :init => 3, :dex => 2 }
			else
				return { :str => 1, :dev => 1, :con => 1, :init => 1, :dex => 1 }
		end
	end
	
	def getHP lvl, con, str, dex
		return 2 * lvl + 2 * con + str + dex
	end
	
end
