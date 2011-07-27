class FightController < ApplicationController
  def show
  	@attack = current_user
  	@defense = User.find params[:id]
  	@log = ""
  	
  	@attack_creature = Creature.new ( Fish.find current_user.fish_id )
  	@defense_creature = Creature.new ( Fish.find @defense.fish_id )
  	@attack_creature.chooseBeginner @defense_creature
  	
  	while @defense_creature.hp > 0 && @attack_creature.hp > 0 do
  		
  		if @attack_creature.turn
  		
  			@attack_creature.preCondition
  			@log += @attack_creature.attack @defense_creature
  			@attack_creature.postCondition
  			@attack_creature.changeTurn @defense_creature
  		else
  			@defense_creature.preCondition
  			@log += @defense_creature.attack @attack_creature
  			@defense_creature.postCondition
  			@defense_creature.changeTurn @attack_creature
  		end
  			@log += "           #{@attack_creature.fish.name}(#{@attack_creature.hp})   #{@defense_creature.fish.name}(#{@defense_creature.hp})<br>"
  	end
  	
  	if @defense_creature.hp <= 0 && @attack_creature.hp <= 0
  		@log += "<br> Uentschieden"
  		@attack_creature.getExp 5
  		@defense_creature.getExp 5
  		@attack.lose += 1
  		@defense.lose += 1
  		@attack.save
  		@defense.save
  	elsif @defense_creature.hp <= 0
  		@log += "<br>#{@attack.nick}s Fish #{@attack_creature.fish.name} gewinnt!"
  		@attack_creature.getExp 10
  		@attack.win += 1;
  		@defense.lose += 1;
  		@attack.save
  		@defense.save
  	else
  		@log += "<br>#{@defense.nick}s Fish #{@defense_creature.fish.name} gewinnt!"
  		@defense_creature.getExp 10
  		@attack.lose += 1;
  		@defense.win += 1;
  		@attack.save
  		@defense.save
  	end
  	
  end

end
