# frozen_string_literal: true

# Artificial Inteligence
class AI
  def random_move(pieces, grid)
    pieces = pieces[:black]
    possible_moves = []

    pieces.each do |piece|
      moves = piece.moves(grid)
      possible_moves << moves unless moves.empty?
    end
    
    possible_moves.sample.sample
  end

  private

  def make_move(piece, dest, grid)
  end
end