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
    pawns && rooks && queens && kings && knights && bishops
    @board.to_s
  end

  private

  def pawns
    8.times { |n| @board.grid[1][n] = Pawn.new(:white, [2, n], @board) }
    8.times { |n| @board.grid[6][n] = Pawn.new(:black, [6, n], @board) }
  end

  def rooks
    @board.grid[0][0] = Rook.new(:white, [0, 0], @board)
    @board.grid[0][7] = Rook.new(:white, [0, 7], @board)
    @board.grid[7][0] = Rook.new(:black, [7, 0], @board)
    @board.grid[7][7] = Rook.new(:black, [7, 7], @board)
  end

  def queens
    @board.grid[0][3] = Queen.new(:white, [0, 3], @board)
    @board.grid[7][3] = Queen.new(:black, [7, 3], @board)
  end

  def kings
    @board.grid[0][4] = King.new(:white, [0, 4], @board)
    @board.grid[7][4] = King.new(:black, [7, 4], @board)
  end

  def knights
    @board.grid[0][1] = Knight.new(:white, [0, 1], @board)
    @board.grid[0][6] = Knight.new(:white, [0, 6], @board)
    @board.grid[7][1] = Knight.new(:black, [7, 1], @board)
    @board.grid[7][6] = Knight.new(:black, [7, 6], @board)
  end

  def bishops
    @board.grid[0][2] = Bishop.new(:white, [0, 2], @board)
    @board.grid[0][5] = Bishop.new(:white, [0, 5], @board)
    @board.grid[7][2] = Bishop.new(:black, [7, 2], @board)
    @board.grid[7][5] = Bishop.new(:black, [7, 5], @board)
  end
end

game = Chess.new('bruno')

game.set_initial_positions