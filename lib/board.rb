# frozen_string_literal: true

require 'colorize'
require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'pawn'

# Chess board with colorize gem
class Board
  attr_accessor :grid

  def initialize(player1, player2 = 'Computer', clean = false)
    @player1 = { name: player1, pieces: :white }
    @player2 = { name: player2, pieces: :black }
    @grid = []
    @pieces = []
    8.times { @grid << [nil, nil, nil, nil, nil, nil, nil, nil] }
    set_initial_positions unless clean
  end

  def to_s
    8.times do |row|
      row = 7 - row
      print "#{row + 1} "
      8.times do |column|
        block = @grid[row][column].nil? ? '   ' : " #{@grid[row][column].unicode} "
        if row.even?
          print column.even? ? block.black.on_light_white : block.white.on_light_black
        else
          print column.odd? ? block.black.on_light_white : block.white.on_light_black
        end
      end
      print "\n"
    end
    puts '   a  b  c  d  e  f  g  h'
  end

  def refresh_grid
    @pieces.each do |piece|
      pos = piece.position
      @grid[pos[1]][pos[0]] = piece
    end
  end

  private

  def set_initial_positions
    pawns && rooks && queens && kings && knights && bishops
    refresh_grid
  end

  def pawns
    8.times { |n| @pieces << Pawn.new(:white, [2, n], self) }
    8.times { |n| @pieces << Pawn.new(:black, [6, n], self) }
  end

  def rooks
    @pieces << Rook.new(:white, [0, 0], self)
    @pieces << Rook.new(:white, [0, 7], self)
    @pieces << Rook.new(:black, [7, 0], self)
    @pieces << Rook.new(:black, [7, 7], self)
  end

  def queens
    @pieces << Queen.new(:white, [0, 3], self)
    @pieces << Queen.new(:black, [7, 3], self)
  end

  def kings
    @pieces << King.new(:white, [0, 4], self)
    @pieces << King.new(:black, [7, 4], self)
  end

  def knights
    @pieces << Knight.new(:white, [0, 1], self)
    @pieces << Knight.new(:white, [0, 6], self)
    @pieces << Knight.new(:black, [7, 1], self)
    @pieces << Knight.new(:black, [7, 6], self)
  end

  def bishops
    @pieces << Bishop.new(:white, [0, 2], self)
    @pieces << Bishop.new(:white, [0, 5], self)
    @pieces << Bishop.new(:black, [7, 2], self)
    @pieces << Bishop.new(:black, [7, 5], self)
  end
end

# board = Board.new

# board.to_s
