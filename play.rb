require './db/setup'
require './lib/all'

puts "What is your name?"
name = gets.chomp

player = User.where(name: name).first
if player
	puts "Welcome back, #{player.name}"

	last_game = player.last_game
	if last_game.nil?
		puts "Did you leave in the middle of a game?"
		elsif last_game.won?
			puts "You won your last game!"
		else
			"It looks like no one won last time."
	end
else
	puts "Welcome, new player. Let's see what you got."
	player = User.create! name: name, wins: 0, losses: 0, draws: 0
end