require 'byebug'

class Tile
  attr_reader :bomb
  attr_accessor :flagged, :revealed

  def initialize(board, bomb = false)
    @bomb = bomb
    @flagged = false
    @revealed = false
    @board = board
  end

  def set_pos(pos)
    @pos = pos
  end

  def reveal
    #debugger
    @revealed = true
    return bomb if @bomb
    if neighbors_bomb_count == 0
      neighbors.each do |tile|
        tile.reveal unless tile.revealed
      end
    end
    neighbors_bomb_count
  end

  def neighbors
    #debugger
    row, col = @pos
    start_row, start_col = row - 1, col - 1
    res = []
    inside_checker = proc { |index| index.between?(0, @board.length - 1) }

    (0..2).each do |x|
      (0..2).each do |y|
        test_row, test_col = start_row + x, start_col + y
        if inside_checker.call(test_row) && inside_checker.call(test_col)
          test_pos = [test_row, test_col]
          res << @board[test_pos] unless x == 1 && y == 1
        end
      end
    end
    res.compact
  end

  def inspect
    "bomb: #{@bomb}, pos: #{@pos}"
  end

  def neighbors_bomb_count
    neighbors.inject(0) do |count, tile|
      tile.bomb ? count + 1 : count
    end
  end

  def to_s
    if @revealed && !@bomb
      neighbors_bomb_count.to_s
    elsif @flagged
      "F"
    elsif @revealed && @bomb
      "*"
    else
      "_"
    end
  end
end
