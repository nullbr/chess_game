# frozen_string_literal: true

require_relative 'pieces'

# king class to treat each king as a node
class King < Pieces
  attr_reader :unicode
  
  def initialize(type, position, board_class)
    super(type, position, board_class)
    @unicode = type == :black ? '♚' : '♔'
  end

  private

  def possible_directions
    [[-1, -1], [-1, 0], [-1, 1], [1, -1], [1, 0], [1, 1], [0, -1], [0, 1]]
  end
end