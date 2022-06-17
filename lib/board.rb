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

  def initialize(player1, player2 = nil)
    @player1 = player1
    @pleyer2 = player2
    @grid = []
    8.times { @grid << [nil, nil, nil, nil, nil, nil, nil, nil] }
    set_initial_positions
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

  private

  def set_initial_positions
    pawns && rooks && queens && kings && knights && bishops
  end

  def pawns
    8.times { |n| @grid[1][n] = Pawn.new(:white, [2, n], self) }
    8.times { |n| @grid[6][n] = Pawn.new(:black, [6, n], self) }
  end

  def rooks
    @grid[0][0] = Rook.new(:white, [0, 0], self)
    @grid[0][7] = Rook.new(:white, [0, 7], self)
    @grid[7][0] = Rook.new(:black, [7, 0], self)
    @grid[7][7] = Rook.new(:black, [7, 7], self)
  end

  def queens
    @grid[0][3] = Queen.new(:white, [0, 3], self)
    @grid[7][3] = Queen.new(:black, [7, 3], self)
  end

  def kings
    @grid[0][4] = King.new(:white, [0, 4], self)
    @grid[7][4] = King.new(:black, [7, 4], self)
  end

  def knights
    @grid[0][1] = Knight.new(:white, [0, 1], self)
    @grid[0][6] = Knight.new(:white, [0, 6], self)
    @grid[7][1] = Knight.new(:black, [7, 1], self)
    @grid[7][6] = Knight.new(:black, [7, 6], self)
  end

  def bishops
    @grid[0][2] = Bishop.new(:white, [0, 2], self)
    @grid[0][5] = Bishop.new(:white, [0, 5], self)
    @grid[7][2] = Bishop.new(:black, [7, 2], self)
    @grid[7][5] = Bishop.new(:black, [7, 5], self)
  end
end

# board = Board.new

# board.to_s
