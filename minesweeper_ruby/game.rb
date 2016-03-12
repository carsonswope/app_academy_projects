# require 'byebug'
require_relative 'board.rb'
require_relative 'tile.rb'

class Game
  def initialize(length = 9, bombs = 10)
    @board = Board.new(length, bombs)
  end

  def play_game
    until over?
      @board.render
      user_move = get_move
      place_move(user_move)
    end
    reveal_all_bombs unless @won
    @board.render
    puts @won ? "congration, you won" : "you lose"
  end

  def place_move(user_move)
    if user_move[0] == "F"
      unless @board[user_move[1]].revealed
        @board[user_move[1]].flagged = true
        @board.flag_count += 1
      end
    elsif user_move[0] == "U"
      if @board[user_move[1]].flagged
        @board[user_move[1]].flagged = false
        @board.flag_count -= 1
      end
    else
      @board[user_move[1]].reveal
    end
  end

  def over?
    revealed_tiles = 0
    @board.length.times do |row|
      @board.length.times do |col|
        pos = [row, col]
        revealed_tiles += 1 if @board[pos].revealed
        if revealed_tiles == @board.length ** 2 - @board.bomb_count
          @won = true
          return true
        elsif @board[pos].bomb && @board[pos].revealed
          @won = false
          return true
        end
      end
    end

    false

  end

  def reveal_all_bombs
    @board.length.times do |row|
      @board.length.times do |col|
        @board[[row, col]].reveal if @board[[row,col]].bomb
      end
    end
  end

  def get_mode
    puts "are you going to flag or reveal or unflag? (enter F, R, or U)"
    move_mode = gets.chomp
    until move_mode == "F" || move_mode == "R" || move_mode == "U"
      puts "invalid input, please try again"
      move_mode = gets.chomp
    end
    move_mode
  end

  def get_position
    checker = proc do | el|
      el.to_i.to_s == el && el.to_i.between?(0, @board.length)
    end

    puts "where is your guess? (Enter row_num, col_num)"
    move_pos = gets.chomp.split(", ")
    until move_pos.all? { |el| checker.call(el) }
      puts "invalid input, please try again"
      move_pos = gets.chomp.split(", ")
    end
    move_pos.map(&:to_i)
  end

  def get_move
    [get_mode, get_position]
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new.play_game
end
