class StatesController < ApplicationController

	def home
		reset_done
	end

	def play	
	  @last_state = State.last
		@state = State.new
	end

	def create
		res = ""
		@stat = State.new(params[:state])
		logic_for_game_flow @stat

		if res.eql?("gameover") || res.eql?("reset")
			flash[:notice] = 'Game Over/ New Game'
			redirect_to :action => :home
		else
			flash[:notice] = 'Enter New State'
			redirect_to :action => :play
		end
	end

	def game_so_far
		@time_stamps = State.pluck(:updated_at)
		@t1_scores = State.pluck(:score1)
		@t2_scores = State.pluck(:score2)
	end
end
