class Fish < ActiveRecord::Base

	has_one :users
  has_many :fish_skills
  has_many :skills, :through => :fish_skills

end
