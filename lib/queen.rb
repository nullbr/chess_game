# frozen_string_literal: true

require_relative 'pieces'

# queen class to treat each queen as a node
class Queen < Pieces
  def initialize(type, position)
    super(type, position)
    @unicode = type == :black ? '♛' : '♕'
    @notation = 'Q'
  end

  def moves(grid)
    moves = []
    directions = possible_directions
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]

      while y.between?(0, 7) && x.between?(0, 7)
        grid[y][x].nil? ? (moves << [y, x, 0]) : (moves << [y, x, 1])
        break unless grid[y][x].nil?

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
