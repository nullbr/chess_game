# frozen_string_literal: true

# bishop class to treat each bishop as a node
class Bishop
  attr_reader :unicode
  
  def initialize(type, position, board_class)
    @type = type
    @unicode = @unicode = @type == :black ? '♝' : '♗'
    @position = position
    @board = board_class
  end

  def bishop_moves
    moves = []
    directions = [[-1, -1], [1, 1], [1, -1], [-1, 1]]
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