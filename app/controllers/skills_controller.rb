class SkillsController < ApplicationController

  def edit
  
  	@s = Skill.where :race => (Fish.find current_user.fish_id).race
  	@a = Fish.find current_user.fish_id
  	@attr = getRaceStat @a.race
  	
  end
  
  def update
  	@s = params[:points]
  	tmp = Fish.find current_user.fish_id
  	tmp.name = params[:name]
  	
  	@s.each do |s|
  	
		if s.first == "Str"
			tmp.str = s.last
		elsif s.first == "Con"
			tmp.con = s.last
		elsif s.first == "Dex"
			tmp.dex = s.last
		elsif s.first == "Init"
			tmp.init = s.last
		elsif s.first == "Dev"
			tmp.dev = s.last
		else
			f = FishSkill.where :fish_id => current_user.fish_id, :skill_id => s.first
			if f.first.nil?
				FishSkill.create :fish_id => current_user.fish_id, :skill_id => s.first, :points => s.last
			else
  				f.first.points = s.last
  			end
  			f.first.save
		end
  	end
	tmp.save
  	
  	redirect_to "/skills/edit"
  end
  
end
