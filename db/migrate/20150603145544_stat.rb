class Stat < ActiveRecord::Migration
  def change
  	create_table "stats" do |s|
  		s.integer "player_x_id"
  		s.integer "wins"
  		s.integer "losses"
  		s.
  		s.datetime "created"
  	end
  end
end
