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
	  				@dev += Math.sqrt(fs.points).to_i
	  			elsif tmp.first.name == "Erhöhte Stärke"
	  				@str += Math.sqrt(fs.points).to_i
	  			elsif tmp.first.name == "Erhöhte Geschicklichkeit"
	  				@dex += Math.sqrt(fs.points).to_i
	  			elsif tmp.first.name == "Erhöhte Konstitution"
	  				@con += Math.sqrt(fs.points).to_i
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
			return "<tr><td>#{def_creature.fish.name}</td><td> kann nicht handeln</td>"
		elsif def_creature.dodge <= 0
			return "<tr><td>#{def_creature.fish.name}</td><td> ist ausgewichen</td>"
		elsif miss <= 0
			return "<tr><td>#{@fish.name}</td><td> hat verfehlt</td>"
		elsif @wuerg != 0
			if rand(@wuerg - @init/3) == 0
				@wuerg = 0
			else
				return "<tr><td>#{def_creature.fish.name}</td><td>kann nicht handeln ist im würgegriff</td>"
			end
		else
			if def_creature.anzahl > 0
				if rand(def_creature.anzahl+1) == 0
					def_creature.anzahl = 0
				else
					def_creature.anzahl -= 1
					return "<tr><td>#{@fish.name}</td><td> greift den falschen an</td>"
				end
			end
			log = def_creature.hitedCondition self
			red = (def_creature.reduce + def_creature.fish.dev*2)/2
			att = @str + 1
			if def_creature.hart
				red /= 2
				def_creature.hart -= 1
			end
			if def_creature.wuerg != 0
				defense_creature.hp -= 4
				log += "<tr><td>#{@fish.name}</td><td> würgt</td><td> #{defense_creature.fish.name}</td><td>-4 HP</td>"
			else
				log += self.selectAttack def_creature, att, red
			end
			return log
		end
	end
	
	def selectAttack def_creature, dmg, red
		fs = FishSkill.where("points > 0").where(:fish_id => @fish.id)
		log = ""
		skills = [ ["Tackle",1], ["Tackle",1], ["Tackle",1] ]
		fs.each do |s|
			tmp = Skill.where :id => s.skill_id, :when => "att"
			unless tmp.first.nil?
				if tmp.first.name == "Meucheln"
					if def_creature.hp <= def_creature.fish.hp/2
						skills += [ ["#{tmp.first.name}", "#{s.points}"] ]
					end
				else
					skills += [ ["#{tmp.first.name}", "#{s.points}"] ]
				end
			end
		end
		att = skills[rand(skills.size)]
		if att[0] == "Tackle"
			dmg = dmg -red
			if dmg <= 0
				dmg = 1
			end
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Blitz"
			dmg = dmg + Math.sqrt(att[1].to_i).to_i
			if rand(3) == 0
				def_creature.para = Math.sqrt(att[1].to_i).to_i
			end
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Vergeltung"
			dmg = dmg - red - 8 + Math.sqrt(att[1].to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg*3
			
			
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
			log += "<td>#{@fish.name}(#{@hp})</td><td>#{def_creature.fish.name}(#{def_creature.hp})</td></tr>"
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
  			log += "<td>#{@fish.name}(#{@hp})</td><td>#{def_creature.fish.name}(#{def_creature.hp})</td></tr>"
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Gift"
			dmg = (dmg - red)/3
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			def_creature.gift = Math.sqrt(att[1].to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Flossenhieb"
			dmg = dmg - red + Math.sqrt(att[1].to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(3) == 0
				def_creature.para = Math.sqrt(att[1].to_i).to_i
			end
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Wunden lecken"
			@hp += @fish.hp/(10-Math.sqrt(att[1].to_i).to_i)
			@blut = 0
			@gift = 0
			log += "<tr><td>{@fish.name}</td><td>#{att[0]}</td><td></td><td>+#{@fish.hp/4} HP</td>"
		elsif att[0] == "Täuschung"
			@anzahl = Math.sqrt(att[1].to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td></td><td>#{Math.sqrt(att[1].to_i).to_i} Ebenbild</td><td></td>"
		elsif att[0] == "Biss"
			dmg = dmg - red + Math.sqrt(att[1].to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Meucheln"
			dmg = dmg*(2+Math.sqrt(att[1].to_i).to_i/2)
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Zerfleischen"
			dmg = dmg*(Math.sqrt(att[1].to_i).to_i/2)
			def_creature.hp -= dmg
			def_creature.blut = Math.sqrt(att[1].to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Blenden"
			dmg = dmg - red
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(3) == 0
				def_creature.para = Math.sqrt(att[1].to_i).to_i
			end
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Schnapper"
			dmg = dmg - red + 2 + Math.sqrt(att[1].to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(3) == 0
				def_creature.para = Math.sqrt(att[1].to_i).to_i
			end
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Schlecken"
			dmg = dmg - red + 1 + Math.sqrt(att[1].to_i.to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(3) == 0
				def_creature.para = Math.sqrt(att[1].to_i.to_i).to_i
			end
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Erhärten"
			@hart = Math.sqrt(att[1].to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td></td><td>#{@hart} Züge stärker</td>"
		elsif att[0] == "Zermalmen"
			dmg = dmg*2 + 5 + Math.sqrt(att[1].to_i.to_i).to_i
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Würgen"
			
		elsif att[0] == "Aufspießen"
			dmg = dmg*2 - red
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			def_creature.blut = Math.sqrt(att[1].to_i.to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		end
		
  		log += "<td>#{@fish.name}(#{@hp})</td><td>#{def_creature.fish.name}(#{def_creature.hp})</td></tr>"
		return log
	end
	
	def hitedCondition fish_attacker
		fs = FishSkill.where("points > 0").where(:fish_id => @fish.id)
		log = ""
		fs.each do |s|
			tmp = Skill.where :id => s.skill_id, :when => "hited"
			unless tmp.first.nil?
				if tmp.first.name == "Dornen"
					fish_attacker.hp -= Math.sqrt(s.points).to_i
					log += "<tr><td>#{fish_attacker.fish.name}</td><td>Dornen</td><td></td><td>-#{Math.sqrt(s.points).to_i}HP</td>"
				elsif tmp.first.name == "Aufgeladen"
					fish_attacker.hp -= Math.sqrt(s.points).to_i
					log += "<tr><td>#{fish_attacker.fish.name}</td><td>Aufladung</td><td>-#{Math.sqrt(s.points).to_i}HP</td>"
				elsif tmp.first.name == "Konter"
					if rand(20-Math.sqrt(s.points).to_i) == 0
						log += "<tr><td>Konter:</td></tr>"
						log += self.attack fish_attacker
					end
				end
			end
		end
		return log
	end
	
	def postCondition
		if @gift != 0
			@hp -= Math.sqrt(@gift).to_i
			return "<tr><td>#{@fish.name}</td><td>Gift</td><td></td><td>-#{@gift}HP</td>"
		end
		if @blut != 0
			@hp -= Math.sqrt(@blut).to_i
			return "<tr><td>#{@fish.name}</td><td>Blutung</td><td></td><td>-#{@blut}HP</td>"
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
