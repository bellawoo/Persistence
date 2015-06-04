class AddPlayer < ActiveRecord::Migration
  def change
  	create_table "players" do |p|
  		p.integer "user_id"
  		p.integer "game_id"
  	end
  	create_table "games" do |g|
  		g.integer "winner_id"
  		g.integer "loser_id"
  	end
  	drop_table :stats
  end
end
