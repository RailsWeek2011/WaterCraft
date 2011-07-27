#ENCODING: utf-8
module FightHelper

end

class Creature
attr_accessor :blut, :gift, :turn, :fish, :para, :hp, :reduce
	def initialize fish
	  	@fish 	= fish
		@blut   = 0
		@gift   = 0
		@para  	= 0
		@hp = @fish.hp
		@turn	= false
		@reduce = 2
		fs = FishSkill.where :fish_id => @fish.id
		fs.each do |s|
			tmp = Skill.where :id => s.skill_id, :when => "hited"
			unless tmp.first.nil?
				if tmp.first.name == "Dehnbarkeit"
					@reduce = 3
				end
			end
		end
	end
	
	def getExp i
		@fish.exp += 10
		@fish.save
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
		return rand(20+@fish.init)
	end
	
	def attack def_creature
		if def_creature.dodge <= 0
			return "#{def_creature.fish.name} ist ausgewichen"
		elsif miss <= 0
			return "#{@fish.name} hat verfehlt"
		elsif @para != 0
			return "#{def_creature.fish.name} kann nicht handeln"
		else
			log = def_creature.hitedCondition self
			self.hitCondition def_creature
			red = (def_creature.reduce * def_creature.fish.dev)/2
			att = @fish.str + 1
			log += self.selectAttack def_creature, att, red
			return log
		end
	end
	
	def selectAttack def_creature, dmg, red
		fs = FishSkill.where("points > 0").where(:fish_id => @fish.id)
		log = ""
		skills = [ "Tackle", "Tackle" ]
		fs.each do |s|
			tmp = Skill.where :id => s.skill_id, :when => "att"
			unless tmp.first.nil?
				puts tmp.first.name
				skills += [ "#{tmp.first.name}" ]
			end
		end
		puts skills
		att = skills[rand(skills.size)]
		if att == "Tackle"
			dmg = dmg -red
			def_creature.hp -= dmg
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab#{log}"
		elsif att == "Blitz"
			dmg = dmg
			def_creature.hp -= dmg
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab#{log}"
		elsif att == "Vergeltung"
			dmg -= red - 6
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg*3
			
			log = "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab#{log}"
			log += "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab#{log}"
			log += "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab#{log}"
			return log
		end
	end
	
	def preCondition
		
	end
	
	def hitedCondition fish_attacker
		fs = FishSkill.where("points > 0").where(:fish_id => @fish.id)
		log = ""
		fs.each do |s|
			tmp = Skill.where :id => s.skill_id, :when => "hited"
			unless tmp.first.nil?
				puts tmp.first.name
				if tmp.first.name == "Dornen"
					fish_attacker.hp -= 1
					log += "<br>#{fish_attacker.fish.name} erleidet durch Dornen 1nen Schaden"
				elsif tmp.first.name == "Aufgeladen"
					fish_attacker.hp -= 1
					log += "<br>#{fish_attacker.fish.name} erleidet durch Aufladung 1nen Schaden"
				elsif tmp.first.name == "Konter"
					if rand(20) == 0
						puts "test"
						log += "<br>Konter:"
						log += self.attack fish_attacker
					end
				end
			end
		end
		return log
	end
	
	def hitCondition fish_attacked
		
	end
	
	def postCondition
		
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
