class AddingDataToTables < ActiveRecord::Migration
  def up
  	names = ["harry","sunil","amirt","akshay","ram","rahim","lakhan",
  		    "rakhi","radha","rani","rekha","seeta","geeta","ratna"]
  	
  	roles = ["seeker","attacker","attacker","attacker","attacker",
  	    	 "goalkeeper","attacker","seeker","attacker","attacker",
  		     "attacker","attacker","attacker","goalkeeper"]	

  	for i in 0..13
  		p = Player.new(:name => names[i], :role => roles[i], :active => true, :score => 0)
  		if i < 7
  		    p.team_id = 1
  		else
  			p.team_id = 2
  		end 
  		p.save!
  	end
  	Team.create!(:no_of_players => 7, :score => 0)
  	Team.create!(:no_of_players => 7, :score => 0)	         
  end

  def down
  end
end
