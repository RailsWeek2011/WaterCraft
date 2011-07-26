class SkillsController < ApplicationController

  def edit
  
  	@s = Skill.where :race => (Fish.find current_user.fish_id).race
  	
  end
  
  def update
  	@s = params[:points]
  	@s.each do |s|
  		f = FishSkill.where :fish_id => current_user.fish_id, :skill_id => s.first
  		if f.first.nil?
  			FishSkill.create :fish_id => current_user.fish_id, :skill_id => s.first, :points => s.last
  		else
  			f.first.points = s.last
  			f.first.save
  		end
  	end
  	redirect_to "/skills/edit"
  end
  
end
