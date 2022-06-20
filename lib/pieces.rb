class Pieces
  attr_reader :unicode
  attr_accessor :notation

  def initialize(type, position)
    @type = type
    @position = position
    @notation = nil
  end

  # takes a position as an array and returns the new position
  def position(x = nil, y = nil)
    @first_move = @position == @initial_pos
    @position = x.nil? ? @position : [y, x]
  end

  def moves(grid)
    directions = possible_directions
    moves = []
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      next unless y.between?(0, 7) && x.between?(0, 7)

      grid[y][x].nil? ? (moves << [y, x, 0]) : (moves << [y, x, 1]) # add legal move to moves, 0 represent not capturing
    end
    moves
  end
end
