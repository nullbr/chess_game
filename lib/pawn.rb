# frozen_string_literal: true

require_relative 'board'

# pawn class to treat each pawn as a node
class Pawn
  def initialize(type, position, board_class)
    @type = type
    @position = position
    @board = board_class
  end

  def pawn_moves
    directions = [[1, 0], [2, 0], [-1, 0], [-2, 0]]
    moves = []
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      moves << [y, x] if y.between?(0, 7) && x.between?(0, 7)
    end
    moves
  end
end

