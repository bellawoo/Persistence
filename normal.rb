require './db/setup'
require './lib/all'

# class Player
#   attr_reader :symbol, :name

#   def initialize symbol
#     @symbol = symbol
#     print "Player #{symbol}! What is your name? "
#     @name = gets.chomp
#   end
# end

class TicTacToe
  attr_reader :current_player

  def initialize player_x, player_o
    # @players = [Player.new(:x), Player.new(:o)]
    @player_x = player_x
    @player_o = player_o
    @board   = Array.new 9

    @current_player = @player_x
    @current_symbol = :x
  end

  def over?
    winner || board_full?
  end

  def board_full?
    !@board.include?(nil)
  end

  def value_in position
    @board[position.to_i - 1]
  end

  def record_move position
    @board[position.to_i - 1] = @current_symbol

  end

  def lines
    [
      [1,2,3],
      [4,5,6],
      [7,8,9],
      [1,4,7],
      [2,5,8],
      [3,6,9],
      [1,5,9],
      [3,5,7]
    ]
  end

  def winner
    lines.each do |line|
      values = line.map { |position| value_in position }
      if values.all? { |v| v == :x }
        return :x
      elsif values.all? { |v| v == :o }
        return :o
      end
    end
    return nil # no winner yet
  end

  def display_board
    "#{display_row(1,2,3)}\n#{display_row(4,5,6)}\n#{display_row(7,8,9)}"
  end

  def display_row a,b,c
    [a,b,c].map { |position| value_in(position) || position }.join ""
  end

  def take_move position
    record_move position
    toggle_players
  end

  def toggle_players
    if @current_player == @player_x
      @current_symbol = :o
      @current_player = @player_o
    else
      @current_player = @player_x
      @current_symbol = :x
    end
  end
end

human = User.make_user
computer = User.make_user
ttt = TicTacToe.new human, computer

until ttt.over?
  puts ttt.display_board
  print "#{ttt.current_player} - where would you like to play? "

  move = gets.chomp
  ttt.take_move move
end

if ttt.winner == :x
  puts "#{human.name} wins!"
  human.stats.wins += 1
elsif ttt.winner == :o
  puts "#{computer.name} wins! You lose!"
  human.stats.losses += 1
else  
  puts "It's a draw"
  human.stats.draws += 1
end
human.save

puts "You've won #{player.stats.wins} games, lost #{player.stats.losses} games, and tied with the computer #{human.stats.draws} times."
