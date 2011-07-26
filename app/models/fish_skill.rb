class FishSkill < ActiveRecord::Base
  belongs_to :fish
  belongs_to :skill
end
