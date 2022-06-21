# frozen_string_literal: true

require_relative 'board'
require 'pry'

# main driver class frot the chess game
class Chess < Board
  def initialize(player1, player2 = nil)
    super(player1, player2)
    @current_player = @player1
    @last_move = [[], []]
  end

  def move_piece(input)
    input = process_input(input)
    return false if input.nil?

    piece = get_piece(input[0], input[1], input[2], input[3]) # (x_dest, y_dest, notation, capturing)
    return false if piece.nil?

    move_to(input[0], input[1], piece, input[4]) # (x_dest, y_dest, piece, promoting_to)
    next_player
    true
  end

  def process_input(input)
    promoting_to = nil
    notation = piece_class.include?(input[0]) ? input[0] : 'P'

    if input.include?('=')
      y_dest = input[-3].to_i - 1
      if piece_class.include?(input[-1]) && notation == 'P' && (y_dest.zero? || y_dest == 7)
        promoting_to = piece_class[input[-1]]
      else
        return
      end
      input = input[0..-3]
    end

    x_dest = input[-2].ord - 97
    y_dest = input[-1].to_i - 1
    capturing = input.include?('x') ? 1 : 0
    return unless x_dest.between?(0, 7) && y_dest.between?(0, 7)

    [x_dest, y_dest, notation, capturing, promoting_to]
  end

  private

  def piece_class
    { 'K' => King, 'Q' => Queen, 'B' => Bishop, 'R' => Rook, 'N' => Knight, 'P' => Pawn }
  end

  def next_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def move_to(x_dest, y_dest, piece, promoting_to)
    x_origin = piece.position[1]
    y_origin = piece.position[0]
    @grid[y_origin][x_origin] = nil

    if promoting_to.nil?
      piece.position(x_dest, y_dest)
      @grid[y_dest][x_dest] = piece
    else
      @grid[y_dest][x_dest] = promoting_to.new(@current_player[:pieces], [y_dest, x_dest])
    end

    @last_move = [[y_origin, x_origin], [y_dest, x_dest]]
  end

  def get_piece(x_dest, y_dest, notation, capturing)
    get = nil
    @pieces.each do |piece|
      next unless piece.type == @current_player[:pieces] && piece.notation == notation &&
                  piece.moves(@grid).include?([y_dest, x_dest, capturing])

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
game.to_s
