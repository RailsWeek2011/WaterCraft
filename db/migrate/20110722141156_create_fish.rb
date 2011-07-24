class CreateFish < ActiveRecord::Migration
  def change
    create_table :fish do |t|
      t.string :name,	:default => "Peter"
      t.integer :race,	:default => 0
      t.integer :dev,	:default => 1
      t.integer :con,	:default => 1
      t.integer :init,	:default => 1
      t.integer :dex,	:default => 1
      t.integer :str,	:default => 1
      t.integer :lvl,	:default => 1
      t.integer :hp,	:default => 6
      t.integer :exp, 	:default => 0

      t.timestamps
    end
  end
end
