# frozen_string_literal: true

# Artificial Inteligence
class AI
  attr_accessor :name

  def initialize(difficulty)
    @difficulty = difficulty # 0 = super easy, 1 = easy
    @name = 'Machine'
  end

  def choose_move(pieces, grid)
    random_move(pieces, grid)
  end

  # calculates all possible moves and returns a randomily selected one
  def random_move(pieces, grid)
    pieces = pieces[:black]
    possible_moves = []

    pieces.each do |piece|
      moves = piece.moves(grid)
      possible_moves += moves.map { |move| move + [piece.notation] } unless moves.empty?
    end
    move = select_capturing(possible_moves)
    translate(move)
  end

  private

  # grabs x
  def translate(move)
    y = move[0] + 1
    x = (move[1] + 97).chr
    capturing = move[2] ? 'x' : ''
    notation = move[3] == 'P' ? '' : move[3]
    "#{notation}#{capturing}#{x}#{y}"
  end

  # choose move, select one with capturing if available
  def select_capturing(possible_moves)
    return possible_moves.sample unless @difficulty > 1 || possible_moves.any? { |move| move[2] == true }

    possible_moves.select { |move| move[2] == true }.sample
  end
end
