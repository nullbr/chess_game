# frozen_string_literal: true

require_relative 'pieces'

# bishop class to treat each bishop as a node
class Bishop < Pieces
  def initialize(type, position)
    super(type, position)
    @unicode = @type == :black ? '♝' : '♗'
    @notation = 'B'
    @rank = 4
  end

  def moves(grid)
    moves = []
    directions = possible_directions
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]

      while y.between?(0, 7) && x.between?(0, 7)
        in_location = grid[y][x]

        unless in_location.nil? # add legal move to moves, 1 represent capturing
          moves << [y, x, true] unless in_location.type == @type
          break
        end
        moves << [y, x, false]
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
