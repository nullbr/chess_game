class Pieces
  attr_reader :unicode

  def initialize(type, position, board_class)
    @type = type
    @position = position
    @board = board_class
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
