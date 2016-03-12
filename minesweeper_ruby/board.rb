# require 'byebug'

class Board
  attr_reader :length, :bomb_count
  attr_accessor :flag_count

  def initialize(length = 9, bomb_count = 10)
    @length = length
    @bomb_count = bomb_count
    @flag_count = 0
    tiles = generate_tiles
    @board = []
    length.times do |row|
      row_cells = []
      length.times do |col|
        tile_to_add = tiles.pop
        tile_to_add.set_pos( [row, col] )
        row_cells << tile_to_add
      end
      @board << row_cells
    end
  end

  def generate_tiles
    tiles = []
    @bomb_count.times do
      tiles << Tile.new(self, true)
    end
    (@length ** 2 - @bomb_count).times { tiles << Tile.new(self) }
    tiles.shuffle!
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def render
    system("clear")
    puts "number of bombs: #{@bomb_count}"
    puts "number of flags: #{@flag_count}"
    @length.times do |row|
      puts @board[row].join(" ")
    end
  end
end
