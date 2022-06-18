# frozen_string_literal: true

require_relative 'board'

# main driver class frot the chess game
class Chess < Board
  def initialize(player1, player2 = nil)
    super(player1, player2)
    @current_player = @player1
  end

  def move_piece(dest)
    x = dest[0].ord - 97
    y = dest[1].to_i - 1

    if @current_player[:pieces] == :white
      piece = @grid[1][x]
      @grid[1][x] = nil
    else
      piece = @grid[6][x]
      @grid[6][x] = nil
    end
    piece.position(x, y)
    @grid[y][x] = piece
    next_player
  end

  def next_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end

game = Chess.new('bruno')
game.move_piece('c3')
game.to_s
