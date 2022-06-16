# frozen_string_literal: true

# knight class to treat each knight as a node
class Knight
  def initialize(type, position, board_class)
    @type = type
    @position = position
    @board = board_class
  end

  def knight_moves
    directions = [[-1, 2], [1, 2], [-1, -2], [1, -2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
    moves = []
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      moves << [y, x] if y.between?(0, 7) && x.between?(0, 7)
    end
    moves
  end
end