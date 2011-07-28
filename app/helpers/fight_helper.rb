#ENCODING: utf-8
module FightHelper

end

class Creature
attr_accessor :blut, :gift, :turn, :fish, :para, :hp, :reduce, :anzahl, :hart, :wuerg
	def initialize fish
	  	@fish 	= fish
	  	@dev	= fish.dev
	  	@str	= fish.str
	  	@dex	= fish.dex
	  	@con	= fish.con
	  	@init	= fish.init
		@blut   = 0
		@gift   = 0
		@anzahl = 0
		@para  	= 0
		@hart   = 0
		@wuerg 	= 0
		@turn	= false
		@reduce = 1
  	
	  	f_id = @fish.id
	  	
	  	(FishSkill.where("points > 0").where :fish_id => f_id).each do |fs|
	  		tmp = Skill.where :id => fs.skill_id, :when => "stat"
	  		unless tmp.first.nil?
	  			if tmp.first.name == "Starke Verteidigung"
	  				@dev += Math.sqrt(fs.points)
	  			elsif tmp.first.name == "Erhöhte Stärke"
	  				@str += Math.sqrt(fs.points)
	  			elsif tmp.first.name == "Erhöhte Geschicklichkeit"
	  				@dex += Math.sqrt(fs.points)
	  			elsif tmp.first.name == "Erhöhte Konstitution"
	  				@con += Math.sqrt(fs.points)
	  			end
			 end
	  	end
	  	
		@hp = 2 * @fish.lvl + 2 * @con + @str + @dex
		
		fs = FishSkill.where :fish_id => @fish.id
		fs.each do |s|
			tmp = Skill.where :id => s.skill_id, :when => "hited"
			unless tmp.first.nil?
				if tmp.first.name == "Dehnbarkeit"
					@reduce = s.points+1
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
		return rand(20)-@dex/5
	end
	
	def miss
		return rand(20+@init)
	end
	
	def attack def_creature
		if @para != 0
			return "#{def_creature.fish.name} kann nicht handeln"
		elsif def_creature.dodge <= 0
			return "#{def_creature.fish.name} ist ausgewichen"
		elsif miss <= 0
			return "#{@fish.name} hat verfehlt"
		elsif @wuerg != 0
			if rand(@wuerg - @init/3) == 0
				@wuerg = 0
			else
				return "#{def_creature.fish.name} kann nicht handeln ist im würgegriff"
			end
		else
			if def_creature.anzahl > 0
				if rand(def_creature.anzahl+1) == 0
					def_creature.anzahl = 0
				else
					def_creature_anzahl -= 1
					return "#{@fish.name} greift den falschen an<br>"
				end
			end
			log = def_creature.hitedCondition self
			self.hitCondition def_creature
			red = (def_creature.reduce + def_creature.fish.dev*2)/2
			att = @str + 1
			if def_creature.hart
				red /= 2
				def_creature.hart -= 1
			end
			if def_creature.wuerg != 0
				defense_creature.hp -= 4
				log += "#{@fish.name} würgt #{defense_creature.fish.name} und verliert 4 HP"
			else
				log += self.selectAttack def_creature, att, red
			end
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
				if tmp.first.name == "Meucheln"
					if def_creature.hp <= def_creature.fish.hp/2
						skills += [ "#{tmp.first.name}" ]
					end
				else
					skills += [ "#{tmp.first.name}" ]
				end
			end
		end
		att = skills[rand(skills.size)]
		if att == "Tackle"
			dmg = dmg -red
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Blitz"
			dmg = dmg
			if rand(3) == 0
				def_creature.para = 1
			end
			def_creature.hp -= dmg
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Vergeltung"
			dmg = dmg - red - 8
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg*3
			
			log = "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
			log += "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
			log += "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
			return log
		elsif att == "Gift"
			dmg = (dmg - red)/3
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			def_creature.gift = 1
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Flossenhieb"
			dmg = dmg - red + 1
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(3) == 0
				def_creature.para = 1
			end
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Wunden lecken"
			@hp += @fish.hp/4	
			return "{@fish.name} #{att} und erhält #{@fish.hp/4} HP zurück<br>"
		elsif att == "Täuschung"
			@anzahl = 1
			return "{@fish.name} erschafft 1 Ebenbild"
		elsif att == "Biss"
			dmg = dmg - red + 1
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Meucheln"
			dmg = dmg*2
			def_creature.hp -= dmg
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Zerfleischen"
			dmg = dmg*1.5
			def_creature.hp -= dmg
			def_creature.blut = 1
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab und lässt es bluten<br>"
		elsif att == "Blenden"
			dmg = dmg - red
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(3) == 0
				def_creature.para = 1
			end
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Schnapper"
			dmg = dmg - red + 3
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(3) == 0
				def_creature.para = 1
			end
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Schlecken"
			dmg = dmg - red + 2
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(3) == 0
				def_creature.para = 1
			end
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"
		elsif att == "Erhärten"
			@hart = 3
			return "#{@fish.name} wird für die nächsten 3 Züge stärker<br>"
		elsif att == "Zermalmen"
			dmg = dmg*2 + 6
			def_creature.hp -= dmg
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab<br>"			
		elsif att == "Würgen"
			
		elsif att == "Aufspießen"
			dmg = dmg*2 - red
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			def_creature.blut = 1
			return "#{@fish.name} #{att} #{def_creature.fish.name} und zieht ihm #{dmg} HP(#{red} Wiederstanden) ab und lässt es bluten<br>"
		end
		return log
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
					fish_attacker.hp -= Math.sqrt(s.points).to_i
					log += "<br>#{fish_attacker.fish.name} erleidet durch Dornen #{Math.sqrt(s.points).to_i}nen Schaden"
				elsif tmp.first.name == "Aufgeladen"
					fish_attacker.hp -= Math.sqrt(s.points).to_i
					log += "<br>#{fish_attacker.fish.name} erleidet durch Aufladung #{Math.sqrt(s.points).to_i}nen Schaden"
				elsif tmp.first.name == "Konter"
					if rand(20) == 0
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
		if @gift != 0
			@hp -= Math.sqrt(@gift).to_i
			return "#{@fish.name} erleidet #{@gift} Schaden durch Gift<br>"
		end
		if @blut != 0
			@hp -= Math.sqrt(@blut).to_i
			return "#{@fish.name} erleidet #{@blut} Schaden durch Blutung<br>"
		end
		return ""
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
