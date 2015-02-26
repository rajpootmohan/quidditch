class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :snitch
      t.string :quaffle
      t.string :reset
      t.string :bludger

      t.timestamps
    end
  end
end
