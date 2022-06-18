class Pieces
  attr_reader :unicode, :capturing

  def initialize(type, position, board_class)
    @type = type
    @position = position
    @board = board_class
    @capturing = []
  end

  # takes a position as an array and returns the new position
  def position(x = nil, y = nil)
    @first_move = @position == @initial_pos
    @position = x.nil? ? @position : [y, x]
  end

  def moves
    directions = possible_directions
    moves = []
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      moves << [y, x] if y.between?(0, 7) && x.between?(0, 7)
    end
    moves
  end
end
