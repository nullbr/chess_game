# frozen_string_literal: true

require_relative 'pieces'

# bishop class to treat each bishop as a node
class Bishop < Pieces
  def initialize(type, position, board_class)
    super(type, position, board_class)
    @unicode = @unicode = @type == :black ? '♝' : '♗'
    @notation = 'B'
  end

  def moves
    moves = []
    directions = possible_directions
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]

      while y.between?(0, 7) && x.between?(0, 7)
        moves << [y, x]
        break unless @board.grid[y][x].nil?

        y += direction[0]
        x += direction[1]
      end
    end
    moves
  end

  private

  def possible_directions
    [[-1, -1], [1, 1], [1, -1], [-1, 1]]
  end
end
