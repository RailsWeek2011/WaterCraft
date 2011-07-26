#ENCODING: utf-8
u = User.new :password => "miaumiau", :nick => "Quallenmann", :email => "Markus_Kretsch@gmx.de", :password_confirmation => "miaumiau", :isAdmin => true
u.isAdmin = true
u.save


u = User.new :nick => "zeyorama", :email => "zeyorama@hotmail.de", :password => "zeyoramaadmin", :password_confirmation => "zeyoramaadmin", :isAdmin => true
u.isAdmin = true
u.save

#skills

Skill.create :name => "Dornen", 				:race => 0, :lvl => 5
Skill.create :name => "Gift", 					:race => 0, :lvl => 30
Skill.create :name => "Flossenhieb", 			:race => 0, :lvl => 35
Skill.create :name => "Aufgeladen", 			:race => 0, :lvl => 60
Skill.create :name => "Vergeltung", 			:race => 1, :lvl => 35
Skill.create :name => "Wunden lecken", 			:race => 1, :lvl => 45
Skill.create :name => "Starke Verteidigung", 	:race => 2, :lvl => 5
Skill.create :name => "Täuschung", 				:race => 2, :lvl => 15
Skill.create :name => "Vergeltung", 			:race => 2, :lvl => 35
Skill.create :name => "Dehnbarkeit", 			:race => 2, :lvl => 50
Skill.create :name => "Aufspießen", 			:race => 2, :lvl => 60
Skill.create :name => "Erhöhtes Ausweichen", 	:race => 3, :lvl => 20
Skill.create :name => "Biss", 					:race => 3, :lvl => 25
Skill.create :name => "Konter", 				:race => 3, :lvl => 30
Skill.create :name => "Flossenhieb", 			:race => 3, :lvl => 35
Skill.create :name => "Vergeltung", 			:race => 3, :lvl => 35
Skill.create :name => "Flossenhieb", 			:race => 3, :lvl => 35
Skill.create :name => "Mecheln", 				:race => 3, :lvl => 45
Skill.create :name => "Aufspießen", 			:race => 3, :lvl => 60
Skill.create :name => "Täuschung", 				:race => 4, :lvl => 15
Skill.create :name => "Erhöhtes Ausweichen", 	:race => 4, :lvl => 20
Skill.create :name => "Biss", 					:race => 4, :lvl => 25
Skill.create :name => "Konter", 				:race => 4, :lvl => 30
Skill.create :name => "Flossenhieb", 			:race => 4, :lvl => 35
Skill.create :name => "Erhöhte Stärke", 		:race => 4, :lvl => 40
Skill.create :name => "Mecheln", 				:race => 4, :lvl => 45
Skill.create :name => "Erhöhte Geschicklichkeit", :race => 4, :lvl => 55
Skill.create :name => "Zerfleischen", 			:race => 4, :lvl => 60
Skill.create :name => "Erhärten", 				:race => 5, :lvl => 15
Skill.create :name => "Täuschung", 				:race => 5, :lvl => 15
Skill.create :name => "Vergeltung", 			:race => 5, :lvl => 35
Skill.create :name => "Wunden lecken", 			:race => 5, :lvl => 45
Skill.create :name => "Dehnbarkeit", 			:race => 5, :lvl => 50
Skill.create :name => "Starke Verteidigung", 	:race => 6, :lvl => 5
Skill.create :name => "Schnapper", 				:race => 6, :lvl => 35
Skill.create :name => "Erhöhte Stärke", 		:race => 6, :lvl => 40
Skill.create :name => "Wunden lecken", 			:race => 6, :lvl => 45
Skill.create :name => "Schlecken", 				:race => 7, :lvl => 10
Skill.create :name => "Erhärten", 				:race => 7, :lvl => 15
Skill.create :name => "Gift", 					:race => 7, :lvl => 30
Skill.create :name => "Täuschung", 				:race => 8, :lvl => 15
Skill.create :name => "Erhöhtes Ausweichen", 	:race => 8, :lvl => 20
Skill.create :name => "Konter", 				:race => 8, :lvl => 30
Skill.create :name => "Mecheln", 				:race => 8, :lvl => 45
Skill.create :name => "Erhöhte Geschicklichkeit", :race => 8, :lvl => 55
Skill.create :name => "Erhöhte Konstitution", 	:race => 9, :lvl => 10
Skill.create :name => "Flossenhieb", 			:race => 9, :lvl => 35
Skill.create :name => "Erhöhte Stärke", 		:race => 9, :lvl => 40
Skill.create :name => "Zermalmen", 				:race => 9, :lvl => 60
Skill.create :name => "Erhärten", 				:race => 10, :lvl => 15
Skill.create :name => "Würgen", 				:race => 10, :lvl => 20
Skill.create :name => "Schnapper", 				:race => 10, :lvl => 35
Skill.create :name => "Erhöhte Stärke", 		:race => 10, :lvl => 40
Skill.create :name => "Zermalmen", 				:race => 10, :lvl => 60
Skill.create :name => "Starke Verteidigung", 	:race => 11, :lvl => 5
Skill.create :name => "Schlecken", 				:race => 11, :lvl => 10
Skill.create :name => "Schnapper", 				:race => 11, :lvl => 35
Skill.create :name => "Wunden lecken", 			:race => 11, :lvl => 45
Skill.create :name => "Erhöhte Konstitution", 	:race => 12, :lvl => 10
Skill.create :name => "Täuschung", 				:race => 12, :lvl => 15
Skill.create :name => "Würgen", 				:race => 12, :lvl => 20
Skill.create :name => "Blenden", 				:race => 12, :lvl => 25
Skill.create :name => "Täuschung", 				:race => 13, :lvl => 15
Skill.create :name => "Erhöhtes Ausweichen", 	:race => 13, :lvl => 20
Skill.create :name => "Flossenhieb", 			:race => 13, :lvl => 35
Skill.create :name => "Erhöhte Geschicklichkeit", :race => 13, :lvl => 55
Skill.create :name => "Dornen", 				:race => 14, :lvl => 5
Skill.create :name => "Erhöhtes Ausweichen", 	:race => 14, :lvl => 20
Skill.create :name => "Vergeltung", 			:race => 14, :lvl => 35
Skill.create :name => "Dehnbarkeit", 			:race => 14, :lvl => 50
Skill.create :name => "Aufgeladen", 			:race => 14, :lvl => 60
Skill.create :name => "Blitz", 					:race => 14, :lvl => 60
Skill.create :name => "Erhöhtes Ausweichen", 	:race => 15, :lvl => 20
Skill.create :name => "Biss", 					:race => 15, :lvl => 25
Skill.create :name => "Konter", 				:race => 15, :lvl => 30
Skill.create :name => "Flossenhieb", 			:race => 15, :lvl => 35
Skill.create :name => "Erhöhte Stärke", 		:race => 15, :lvl => 40
Skill.create :name => "Mecheln", 				:race => 15, :lvl => 45
Skill.create :name => "Zerfleischen", 			:race => 15, :lvl => 60

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
