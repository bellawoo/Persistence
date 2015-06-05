require 'pry'
require './db/setup'
require './lib/all'

class Person
  attr_reader :symbol, :name

  def initialize symbol, name=nil
    @symbol = symbol
    print "Player #{symbol}! What is your name? "
    @name = name || gets.chomp
  end

  def store_user
    User.where(name: name).first_or_create!
  end
end

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

  def winner_storage
    if winner == :x
      winner = User.where(name: @player_x.name).first
      loser = User.where(name: @player_o.name).first
    elsif winner == :o
      winner = User.where(name: @player_o.name).first
      loser = User.where(name: @player_x.name).first
    else
      nil
    end
    binding.pry
    Game.create(winner_id: winner.id, loser_id: loser.id)
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

human = Person.new :x, "Shoe"
computer = Person.new :o, "Cup"
human.store_user
computer.store_user
ttt = TicTacToe.new human, computer

until ttt.over?
  puts ttt.display_board
  print "#{ttt.current_player} - where would you like to play? "

  move = gets.chomp
  ttt.take_move move
end

if ttt.winner == :x
  puts "#{ttt.winner} wins!"
elsif ttt.winner == :o
  puts "#{ttt.winner} wins!"
else  
  puts "It's a draw"
end

ttt.winner_storage

