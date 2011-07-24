u = User.new :password => "miaumiau", :nick => "Quallenmann", :email => "Markus_Kretsch@gmx.de", :password_confirmation => "miaumiau", :isAdmin => true
u.isAdmin = true
u.save


u = User.new :nick => "zeyorama", :email => "zeyorama@hotmail.de", :password => "zeyoramaadmin", :password_confirmation => "zeyoramaadmin", :isAdmin => true
u.isAdmin = true
u.save

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
