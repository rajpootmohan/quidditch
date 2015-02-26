class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :role
      t.integer :team_id
      t.boolean :active
      t.integer :score

      t.timestamps
    end
  end
end
