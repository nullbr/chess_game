# frozen_string_literal: true

require_relative 'pieces'

# pawn class to treat each pawn as a node
class Pawn < Pieces
  def initialize(type, position, board_class)
    super(type, position, board_class)
    @unicode = type == :black ? '♟' : '♙'
    @initial_pos = position
    @first_move = false
  end

  def moves
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

  # returns true if pawn has reached the end of the board
  def promoted?
    @position[0].zero? && @type == :black || @position[0] == 7 && @type == :white
  end

  # returns true if the pawn is 'in passing'
  # special rule that allows it to be captured by another pawn
  def en_passant?
    @first_move &&
      @type == :black && (@position[0] + 2) == @initial_pos[0] ||
      @type == :white && (@position[0] - 2) == @initial_pos[0]
  end

  private

  def possible_directions
    if @position == @initial_pos
      if @type == :black
        [[-1, 0], [-2, 0]]
      else
        [[1, 0], [2, 0]]
      end
    elsif @type == :black
      [[-1, 0]]
    else
      [[1, 0]]
    end
  end
end
