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
    input = input.split('')
    x = get_coordinates(input, [97, 104]).map { |char| char.ord - 97 } # check for x coordinates
    y = get_coordinates(input, [48, 57]).map { |char| char.to_i - 1 } # check for y coordinates
    notation = piece_class.include?(input[0]) ? input[0] : 'P' # notation
    promoting_to = promoting(input, notation, y[0]) if input.include?('=')
    return unless x.size.between?(1, 2) && y.size.between?(1, 2) && promoting_to != false

    [x[0], y[0], notation, input.include?('x'), promoting_to, y[1] || x[1]]
  end

  private

  def get_coordinates(input, range)
    input.select { |char| char.ord.between?(range[0], range[1]) }.reverse
  end

  def promoting(input, notation, y_dest)
    if piece_class.include?(input[-1]) && notation == 'P' && (y_dest.zero? || y_dest == 7)
      piece_class[input[-1]]
    else
      false
    end
  end

  def piece_class
    { 'K' => King, 'Q' => Queen, 'B' => Bishop, 'R' => Rook, 'N' => Knight, 'P' => Pawn }
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

  def next_player
    @current_player = @current_player == @player1 ? @player2 : @player1
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
