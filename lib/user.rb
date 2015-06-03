class User < ActiveRecord::Base
	has_many :stat
	validates_uniqueness_of :name

	def last_game
		Stat.order(created: :desc).first
	end

	def self.make_user
		puts "What is your name?"
		name = gets.chomp
		player = User.where(name: name).first
		if player
			puts "Welcome back!"
			last_game = player.last_game

			if last_game.nil?
				puts "You haven't finished a game?"
			elsif last_game.won?
				puts "You won your last game!"
			else
				puts "Maybe your skills will show this time."
			end
		else
			puts "Welcome, new player."
			player = User.create!(name: name)
			player.Stat.create!(wins: 0, losses: 0, draws: 0)
		end
	end
end