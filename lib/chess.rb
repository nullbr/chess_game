# frozen_string_literal: true

require_relative 'board'

# main driver class frot the chess game
class Chess < Board
  def initialize(player1, player2 = nil)
    super(player1, player2)
    @current_player = @player1
  end

  def move_piece(dest)
    if dest.size == 2
      x_dest = dest[0].ord - 97
      y_dest = dest[1].to_i - 1
      piece = get_pawn(x_dest, y_dest)
    end

    move_to(x_dest, y_dest, piece)
    next_player
  end

  private

  def next_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def move_to(x_dest, y_dest, piece)
    x_origin = piece.position[1]
    y_origin = piece.position[0]

    @grid[y_origin][x_origin] = nil
    piece.position(x_dest, y_dest)
    @grid[y_dest][x_dest] = piece
  end

  def get_pawn(x_dest, y_dest)
    if @current_player[:pieces] == :white
      pawn = @grid[1][x_dest]
      pawn.en_passant = (pawn.first_move && y_dest == 3) ? true : false 
    else
      pawn = @grid[6][x_dest]
      pawn.en_passant = (pawn.first_move && y_dest == 4) ? true : false
    end

    pawn.first_move = false
    pawn
  end
end

game = Chess.new('bruno')
game.move_piece('c3')
game.to_s
