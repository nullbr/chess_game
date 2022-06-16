# frozen_string_literal: true

# rook class to treat each rook as a node
class Rook
  def initialize(type, position, board_class)
    @type = type
    @unicode =  @type == :black ? '♜' : '♖'
    @position = position
    @board = board_class
  end

  def rook_moves
    moves = []
    directions = [[-1, 0], [0, -1], [1, 0], [0, 1]]
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      unless @board.grid[y][x].nil?
        moves << [y, x]
        next
      end

      while y.between?(0, 7) && x.between?(0, 7)
        moves << [y, x]
        y += direction[0]
        x += direction[1]
      end
    end
    moves
  end
end