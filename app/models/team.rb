class Team < ActiveRecord::Base
  attr_accessible :no_of_players, :score

  has_many :players

  validates :no_of_players, :inclusion => 0..7

  def self.find_first_team
  	first
  end

  def self.find_second_team
  	last
  end
end
