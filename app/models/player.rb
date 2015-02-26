class Player < ActiveRecord::Base
  attr_accessible :active, :name, :role, :score

  belongs_to :team, :class_name => "Team", :foreign_key => "team_id"

  def self.players_list(type)
  	if !type.eql?("all")
  	   where(:active => true, :role => type).pluck(:name)
    else
       where(:active => true).pluck(:name)
    end
  end
end
