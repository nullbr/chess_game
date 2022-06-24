# frozen_string_literal: true

require 'colorize'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'pawn'
require 'pry'

# Chess board with colorize gem
class Board
  attr_accessor :grid

  def initialize(player1, player2 = 'Computer', clean = false)
    @player1 = { name: player1, pieces: :white }
    @player2 = { name: player2, pieces: :black }
    @grid = []
    @all_pieces = { white: [], black: [] }
    @last_move = [[], [], nil]
    @all_moves = []
    @captured = []
    8.times { @grid << [nil, nil, nil, nil, nil, nil, nil, nil] }
    set_initial_positions unless clean
  end

  def to_s
    8.times do |row|
      row = 7 - row
      print "#{row + 1} "
      8.times do |column|
        block = @grid[row][column].nil? ? '   ' : " #{@grid[row][column].unicode} "
        if row == @last_move[0][0] && column == @last_move[0][1] || row == @last_move[1][0] && column == @last_move[1][1]
          print block.black.on_light_cyan
        elsif row.even?
          print column.even? ? block.black.on_light_white : block.white.on_light_black
        else
          print column.odd? ? block.black.on_light_white : block.white.on_light_black
        end
      end
      print "\n"
    end
    puts "   a  b  c  d  e  f  g  h\n"
    puts "Moves: #{@all_moves}"
    puts "Captures: #{@captured}"
  end

  def refresh_grid
    @all_pieces.each do |_type, pieces|
      pieces.each do |piece|
        pos = piece.position
        @grid[pos[0]][pos[1]] = piece
      end
    end
  end

  private

  def set_initial_positions
    pawns && rooks && queens && kings && knights && bishops
    refresh_grid
  end

  def pawns
    8.times { |n| @all_pieces[:white] << Pawn.new(:white, [1, n]) }
    8.times { |n| @all_pieces[:black] << Pawn.new(:black, [6, n]) }
  end

  def rooks
    @all_pieces[:white] << Rook.new(:white, [0, 0])
    @all_pieces[:white] << Rook.new(:white, [0, 7])
    @all_pieces[:black] << Rook.new(:black, [7, 0])
    @all_pieces[:black] << Rook.new(:black, [7, 7])
  end

  def queens
    @all_pieces[:white] << Queen.new(:white, [0, 3])
    @all_pieces[:black] << Queen.new(:black, [7, 3])
  end

  def kings
    @all_pieces[:white] << King.new(:white, [0, 4])
    @all_pieces[:black] << King.new(:black, [7, 4])
  end

  def knights
    @all_pieces[:white] << Knight.new(:white, [0, 1])
    @all_pieces[:white] << Knight.new(:white, [0, 6])
    @all_pieces[:black] << Knight.new(:black, [7, 1])
    @all_pieces[:black] << Knight.new(:black, [7, 6])
  end

  def bishops
    @all_pieces[:white] << Bishop.new(:white, [0, 2])
    @all_pieces[:white] << Bishop.new(:white, [0, 5])
    @all_pieces[:black] << Bishop.new(:black, [7, 2])
    @all_pieces[:black] << Bishop.new(:black, [7, 5])
  end
end

# board = Board.new('bruno')

# board.to_s
