# frozen_string_literal: true

require_relative 'pieces'

# king class to treat each king as a node
class King < Pieces

  def initialize(type, position)
    super(type, position)
    @unicode = type == :black ? '♚' : '♔'
    @notation = 'K'
  end

  private

  def possible_directions
    [[-1, -1], [-1, 0], [-1, 1], [1, -1], [1, 0], [1, 1], [0, -1], [0, 1]]
  end
end