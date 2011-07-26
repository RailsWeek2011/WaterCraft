class CreateFishSkills < ActiveRecord::Migration
  def change
    create_table :fish_skills do |t|
      t.references :fish
      t.references :skill
      t.integer :points

      t.timestamps
    end
    add_index :fish_skills, :fish_id
    add_index :fish_skills, :skill_id
  end
end
