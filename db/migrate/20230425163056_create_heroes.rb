class CreateHeroes < ActiveRecord::Migration[5.2]
  def change
    create_table :heroes do |t|
      t.string :name
      t.integer :attack
      t.integer :defense
      t.integer :life

      t.timestamps
    end
  end
end
