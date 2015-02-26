class AddScore1AndScore2ToState < ActiveRecord::Migration
  def change
    add_column :states, :score1, :integer
    add_column :states, :score2, :integer
  end
end
