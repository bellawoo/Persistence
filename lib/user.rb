class User < ActiveRecord::Base
	validates_uniqueness_of :name

	def last_game
		stats.order(created_at: :desc).first
	end
end