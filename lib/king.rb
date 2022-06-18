# frozen_string_literal: true

# king class to treat each king as a node
class King
  attr_reader :unicode
  
  def initialize(type, position, board_class)
    @type = type
    @unicode = @unicode = @type == :black ? '♚' : '♔'
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

  private

  def possible_directions
    [[-1, -1], [-1, 0], [-1, 1], [1, -1], [1, 0], [1, 1], [0, -1], [0, 1]]
  end
end