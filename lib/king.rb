# frozen_string_literal: true

# king class to treat each king as a node
class King
  def initialize(type, position, board_class)
    @type = type
    @position = position
    @board = board_class
  end

  def king_moves
    directions = [[-1, -1], [-1, 0], [-1, 1], [1, -1], [1, 0], [1, 1], [0, -1], [0, 1]]
    moves = []
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      moves << [y, x] if y.between?(0, 7) && x.between?(0, 7)
    end
    moves
  end
end