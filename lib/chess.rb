# frozen_string_literal: true

require_relative 'board'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'pawn'

# main driver class frot the chess game
class Chess
  def initialize(player1, player2 = nil)
    @player1 = player1
    @pleyer2 = player2
  end

  def set_initial_positions
    @board = Board.new

    pawns

    @board.to_s
  end

  private

  def pawns
    8.times { |n| @board.grid[1][n] = Pawn.new(:white, [2, n], @board) }

    8.times { |n| @board.grid[6][n] = Pawn.new(:black, [6, n], @board) }
  end
end

game = Chess.new('bruno')

game.set_initial_positions