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

    piece = get_piece(input[0], input[1], input[2], input[3], input[5]) # (x_dest, y_dest, notation, capturing, origin)
    return false if piece.nil?

    move_to(input[0], input[1], piece, input[4]) # (x_dest, y_dest, piece, promoting_to)
    next_player
    true
  end

  def process_input(input)
    input = input.split('')
    return unless input_valid?(input)

    x = get_x_coordinates(input)
    y = get_y_coordinates(input)
    notation = get_name(input)
    promoting_to = promoting(input, notation, y[0]) if input.include?('=')
    check = input[-1] == '#' || input[-1] == '+' ? input[-1] : nil
    return unless x.size.between?(1, 2) && y.size.between?(1, 2) && promoting_to != false

    [x[0], y[0], notation, input.include?('x'), promoting_to, y[1] || x[1], check]
  end

  private

  # check if the input has the right params
  def input_valid?(input)
    # input includes on valid characters:
    valid_chars = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
                   '1', '2', '3', '4', '5', '6', '7', '8',
                   'x', '=', '+', '#', 'K', 'Q', 'B', 'R', 'N', 'P']
    input.all? { |char| valid_chars.include?(char) } &&
      input.select { |char| char.ord.between?(97, 104) }.size.between?(1, 2) &&
      input.select { |char| char.ord.between?(48, 57) }.size.between?(1, 2)
  end

  # takes in the input, gets coodinates info and returns it. Returns empty array if invalid info
  def get_x_coordinates(input)
    input.map { |char| char.ord - 97 }.select { |char| char.between?(0, 7) }.reverse
  end

  # takes in the input, gets coodinates info and returns it. Returns empty array if invalid info
  def get_y_coordinates(input)
    input = input.select { |char| char.ord.between?(48, 57) }
    input = input.map { |char| char.to_i - 1 }.reverse

    if input.size.between?(1, 2) && input.all? { |num| num.between?(0, 7) }
      input
    else
      []
    end
  end

  # takes input and returns the name of the piece or piece promoting to
  def get_name(input)
    return if input.select { |char| char.ord.between?(65, 90) }.size > 1

    if input.include?('=') || !piece_class.include?(input[0])
      'P'
    else
      input[0]
    end
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

  def get_piece(x_dest, y_dest, notation, capturing, origin)
    get = nil
    @pieces.each do |piece|
      next unless piece.type == @current_player[:pieces] && piece.notation == notation &&
                  piece.moves(@grid).include?([y_dest, x_dest, capturing]) &&
                  origin.nil? || piece.position.include?(origin)

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

# game = Chess.new('bruno')
# game.to_s
