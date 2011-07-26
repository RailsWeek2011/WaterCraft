class Skill < ActiveRecord::Base
  has_many :fish_skills
  has_many :fishs, :through => :fish_skills
end
