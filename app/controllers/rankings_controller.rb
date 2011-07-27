class RankingsController < ApplicationController
  
  def rank
  id = params[:id].to_i 
  
    case id
    	when 1 # EXP
			@f = Fish.find :all, :order => "exp DESC"
		
    	when 2 # LVL
    		@f = Fish.find :all, :order => "lvl DESC"
    		
    	when 3 # Kämpfe
    		@u = User.find :all, :order => "win DESC"
    		@f = Fish.all
			
		else
			@f = Fish.all
			
    end
    
  end

end
