# frozen_string_literal: true

# queen class to treat each queen as a node
class Queen
  attr_reader :unicode
  
  def initialize(type, position, board_class)
    @type = type
    @unicode = @unicode = @type == :black ? '♛' : '♕'
    @position = position
    @board = board_class
  end

  def moves
    moves = []
    directions = possible_directions
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

  private

  def possible_directions
    [[-1, -1], [-1, 0], [-1, 1], [1, -1], [1, 0], [1, 1], [0, -1], [0, 1]]
  end
end