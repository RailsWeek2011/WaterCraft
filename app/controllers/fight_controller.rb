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
  			@log += @defense_creature.postCondition
  			@defense_creature.changeTurn @attack_creature
  		end
  			@log += "           #{@attack_creature.fish.name}(#{@attack_creature.hp})   #{@defense_creature.fish.name}(#{@defense_creature.hp})<br>"
  	end
  	
  	if @defense_creature.hp <= 0 && @attack_creature.hp <= 0
  		@log += "<br> Uentschieden"
  		@attack_creature.getExp 5
  		@defense_creature.getExp 5
  		if @defense_creature.fish.exp >= nextLvl( @defense_creature.fish.lvl )
  			puts nextLvl( @defense_creature.fish.lvl )
  			@defense_creature.fish.lvl += 1
  			@defense_creature.fish.hp = getHP @defense_creature.fish.lvl, @defense_creature.fish.con, @defense_creature.fish.str, @defense_creature.fish.dex
  			@defense_creature.fish.save
  		end
  		if @attack_creature.fish.exp >= nextLvl( @attack_creature.fish.lvl )
  			@attack_creature.fish.lvl += 1
  			@attack_creature.fish.hp = getHP @attack_creature.fish.lvl, @attack_creature.fish.con, @attack_creature.fish.str, @attack_creature.fish.dex
  			@attack_creature.fish.save
  		end
  		@attack.lose += 1
  		@defense.lose += 1
  		@attack.save
  		@defense.save
  	elsif @defense_creature.hp <= 0
  		@log += "<br>#{@attack.nick}s Fish #{@attack_creature.fish.name} gewinnt!"
  		@attack_creature.getExp 10
  		if @attack_creature.fish.exp >= nextLvl( @attack_creature.fish.lvl )
  			@attack_creature.fish.lvl += 1
  			@attack_creature.fish.hp = getHP @attack_creature.fish.lvl, @attack_creature.fish.con, @attack_creature.fish.str, @attack_creature.fish.dex
  			@attack_creature.fish.save
  		end
  		@attack.win += 1;
  		@defense.lose += 1;
  		@attack.save
  		@defense.save
  	else
  		@log += "<br>#{@defense.nick}s Fish #{@defense_creature.fish.name} gewinnt!"
  		@defense_creature.getExp 10
  		if @defense_creature.fish.exp >= nextLvl( @defense_creature.fish.lvl )
  			puts nextLvl( @defense_creature.fish.lvl )
  			@defense_creature.fish.lvl += 1
  			@defense_creature.fish.hp = getHP @defense_creature.fish.lvl, @defense_creature.fish.con, @defense_creature.fish.str, @defense_creature.fish.dex
  			@defense_creature.fish.save
  		end
  		@attack.lose += 1;
  		@defense.win += 1;
  		@attack.save
  		@defense.save
  	end
  	
  end

  def nextLvl lvl
	exp = 0
	lvl.times do
		exp += 90
	end
	return exp
  end

end
