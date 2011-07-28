class RankingsController < ApplicationController
  
  def rank
  @id = params[:id].to_i 
  
    case @id
    	when 1 # EXP
			@f = Fish.order('exp desc')
    	when 2 # LVL
			@f = Fish.order('exp asc')
    	when 3 # Siege
    		@f = Fish.order('lvl desc')
    	when 4
    		@f = Fish.order('lvl asc')
    	when 5
    		@u = User.order('win desc')
    	when 6
    		@u = User.order('win asc')
    	when 7
    		@u = User.where('win+lose > 0').order('win/win+lose desc')
    	when 8
    		@u = User.where('win+lose > 0').order('win/win+lose asc')
		else
			@f = Fish.all
			
    end
    
  end

end
