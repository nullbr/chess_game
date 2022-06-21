# frozen_string_literal: true

require_relative 'board'
require 'pry'

# main driver class frot the chess game
class Chess < Board
  def initialize(player1, player2 = nil)
    super(player1, player2)
    @current_player = @player1
    @last_move = []
  end

  def move_piece(dest)
    x_dest = dest[-2].ord - 97
    y_dest = dest[-1].to_i - 1
    if dest.size == 2
      notation = 'P'
    elsif dest.size == 3
      notation = dest[0]
    end

    piece = get_piece(x_dest, y_dest, notation)
    return false if piece.nil?

    move_to(x_dest, y_dest, piece)
    next_player
    true
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

    @last_move = [[y_origin, x_origin], [y_dest, x_dest]]
  end

  def get_piece(x_dest, y_dest, notation)
    get = nil
    @pieces.each do |piece|
      next unless piece.type == @current_player[:pieces] && piece.notation == notation &&
                  piece.moves(@grid).include?([y_dest, x_dest, (0 || 1)])

      check_pawn(piece, y_dest) if piece.notation == 'P'
      get = piece
      break
    end
    get
  end

  def check_pawn(pawn, y_dest)
    pawn.en_passant = if @current_player[:pieces] == :white
                        pawn.first_move && y_dest == 3 ? true : false
                      else
                        pawn.first_move && y_dest == 4 ? true : false
                      end

    pawn.first_move = false
  end
end

game = Chess.new('bruno')
game.move_piece('Nf3')
game.move_piece('Nf6')
game.move_piece('d3')
game.to_s
