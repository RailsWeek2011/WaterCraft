#ENCODING: utf-8
module FightHelper

end

class Creature
attr_accessor :blut, :gift, :turn, :fish, :para, :hp
	def initialize fish
	  	@fish 	= fish
		@blut   = 0
		@gift   = 0
		@para  	= 0
		@hp = @fish.hp
		@turn	= false
	end

	def chooseBeginner def_creature
		d = fish.init - def_creature.fish.init
	
		if d >= 0
			d = rand(d+2)
			if d == 0
				@turn = false
				def_creature.turn = true
			else
				@turn = true
				def_creature.turn = false
			end
		else
			d = rand(-d+2)
			if d == 0
				@turn = true
				def_creature.turn = false
			else
				@turn = false
				def_creature.turn = true
			end
		end
	end
	
	def dodge
		return rand(20)-@fish.dex
	end
	
	def miss
		return rand(20+@fish.dex)
	end
	
	def attack def_creature
		if def_creature.dodge <= 0
			return "#{def_creature.fish.name} ist ausgewichen"
		elsif miss <= 0
			return "#{@fish.name} hat verfehlt"
		else
			def_creature.hp -= @fish.str
			return "#{@fish.name} tacklet #{def_creature.fish.name} und zieht ihm #{@fish.str} HP ab"
		end
	end
	
	def changeTurn def_creature
		if @turn
			@turn = false
			def_creature.turn = true
		else
			@turn = true
			def_creature.turn = false
		end
	end	
	
end
