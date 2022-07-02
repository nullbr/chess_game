# frozen_string_literal: true

require_relative 'pieces'

# knight class to treat each knight as a node
class Knight < Pieces
  def initialize(type, position)
    super(type, position)
    @unicode = type == :black ? '♞' : '♘'
    @notation = 'N'
    @rank = 3
  end

  private

  def possible_directions
    [[-1, 2], [1, 2], [-1, -2], [1, -2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
  end
end
