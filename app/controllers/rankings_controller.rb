class RankingsController < ApplicationController
  
  def rank
  id = params[:id].to_i 
  
    case id
    	when 1 # EXP
			@f = Fish.find :all, :order => "exp DESC"
		
    	when 2 # LVL
    		@f = Fish.find :all, :order => "lvl DESC"
			
		else
			@f = Fish.all
			
    end
    
  end

end
