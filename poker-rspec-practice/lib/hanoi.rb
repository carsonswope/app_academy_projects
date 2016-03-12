class Hanoi
  attr_reader :towers

  def initialize
    @towers = [[3,2,1],[],[]]
  end

  def render
    puts "Tower 1: #{@towers[0].join(" ")}\nTower 2: #{@towers[1].join(" ")}\nTower 3: #{@towers[2].join(" ")}"
  end

  def won?
    @towers == [[],[],[3,2,1]]
  end

  def move(move_ary)
    from, to = move_ary

    #errors
    raise OutOfBoundsError if !from.between?(0,2) || !to.between?(0,2)
    raise InvalidMoveError if @towers[from].empty?
    raise InvalidMoveError if !@towers[to].empty? && @towers[from].last > @towers[to].last

    @towers[to].push(@towers[from].pop)
  end

end

class OutOfBoundsError < StandardError
end

class InvalidMoveError < StandardError
end
