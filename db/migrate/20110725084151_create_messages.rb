class CreateMessages < ActiveRecord::Migration
  
  def change
    create_table :messages do |t|
      t.references :from
      t.references :to
      t.text :body

      t.timestamps
    end
  end
  
end