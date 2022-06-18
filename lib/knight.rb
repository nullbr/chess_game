# frozen_string_literal: true

require_relative 'pieces'

# knight class to treat each knight as a node
class Knight < Pieces
  attr_reader :unicode

  def initialize(type, position, board_class)
    super(type, position, board_class)
    @unicode = type == :black ? '♞' : '♘'
  end

  private

  def possible_directions
    [[-1, 2], [1, 2], [-1, -2], [1, -2], [-2, -1], [-2, 1], [2, -1], [2, 1]]
  end
end
