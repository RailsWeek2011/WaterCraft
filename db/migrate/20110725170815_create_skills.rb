class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.integer :race
      t.integer :lvl
      t.text :beschreibung
      t.string :when

      t.timestamps
    end
  end
end
