module StatesHelper

	def list_for_quaffle
        @pList = @pList || list_of_players("attacker")
        @pList.include?("Goal1")? @pList: @pList.append("Goal1")
        @pList.include?("Goal2")? @pList: @pList.append("Goal2")
	end

	def list_for_snitch
        @seekerList = @seekerList || list_of_players("seeker")    
	end	

	def list_of_players type		
		@playerList = Player.players_list(type)
        @playerList.include?("Air")? @playerList: @playerList.prepend("Air")
	end

	def reset_done
        @teams = Team.all
        @teams.each do |t|
            	t.no_of_players = 7
            	t.score = 0
            	t.save!
        end
        players = Player.all
        players.each do |p|
            	p.active = true
            	p.score = 0
            	p.save!
        end
        State.delete_all
	end

	def snitch_caught name
	    @team = Team.includes(:players).where(:players => {:name => name}).first
		@team.score = @team.score + 250
		@team.save
        p = @team.players.first
        p.score = p.score + 250
		flash[:team_win] = "Team " + @team.id.to_s + " wins"
	    res = "gameover"
	end

	def quaffle_hit_goal name
        k = 1	
        if name.eql?("Goal1")
        	  @team = Team.find_second_team
        else
        	  @team = Team.find_first_team
        	  k = 2
        end
        p = State.pluck(:quaffle).reverse
        for i in 0..7
                player = Player.find_by_name(p[i])
        	  	if p[i] != "Goal1" && p[i] != "Goal2" && !player.nil? && player.team_id != k
                    player.score = player.score + 10
                    player.save!
                    k = 0
        	  		break
        	  	end
        end
        if k == 0
            @team.score = @team.score + 10 	
            if @team.score >= 250
                res = "teamwin"
                flash[:teamwin] = "Team#{@team.id} wins"
            end
            @team.save!
        end
        res
    end

    def bludger_hit_someone name
    	t = Team.includes(:players).where(:players => {:name => name}).first

    	if t.no_of_players > 1
    		t.no_of_players = t.no_of_players - 1
    	else
         	res = "gameover" 	
            flash[:min_player] = "Game Over Because Team #{t.id} Have 0 Players"
    	end
    	p = t.players.first
    	p.active = false
    	p.save
    	t.save
        res
    end

    def current_state_score
        Team.pluck(:score)
    end

    def logic_for_game_flow state
        #code for snitch(Higher Priority)
        if Player.players_list("all").include?(state[:snitch])

            res = snitch_caught(state[:snitch])

        #code for restart(2nd Highest Priority)
        elsif Player.players_list("all").include?(state[:reset])

            reset_done
            flash[:reset] = "Reset Done"
            res = "reset"       

        else
            #code to handle quaffle(3rd Highest Priority)
            if state[:quaffle].eql?("Goal1") || state[:quaffle].eql?("Goal2")

                res = quaffle_hit_goal(state[:quaffle])

            end
            #code to handle bludger(4th Highest Priority)
            if !state[:bludger].eql?("Air")

                res = bludger_hit_someone(state[:bludger])

            end
        end
        scores = current_state_score
        state.score1 = scores.first
        state.score2 = scores.last
        state.save!
    end
    
end
