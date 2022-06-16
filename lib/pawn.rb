# frozen_string_literal: true

# pawn class to treat each pawn as a node
class Pawn
  attr_accessor :position

  def initialize(type, position, board_class)
    @type = type
    @position = position
    @board = board_class
    @first_postion = position
  end

  def pawn_moves
    directions = possible_directions
    moves = []
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      break unless @board.grid[y][x].nil?

      moves << [y, x] if y.between?(0, 7) && x.between?(0, 7)
    end
    moves
  end

  private

  def possible_directions
    if @type == :black && @first_postion == @position
      [[-1, 0], [-2, 0]]
    elsif @type == :black
      [[-1, 0]]
    elsif @type == :white && @first_postion == @position
      [[1, 0], [2, 0]]
    else
      [[1, 0]]
    end
  end
end
