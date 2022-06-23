# frozen_string_literal: true

require_relative 'pieces'
require 'pry'

# pawn class to treat each pawn as a node
class Pawn < Pieces
  attr_accessor :first_move, :en_passant

  def initialize(type, position)
    super(type, position)
    @unicode = type == :black ? '♟' : '♙'
    @initial_pos = position
    @first_move = true
    @en_passant = false
    @notation = 'P'
  end

  def moves(grid)
    moves = []
    
    possible_directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      
      break unless y.between?(0, 7) && x.between?(0, 7) && grid[y][x].nil?

      moves << [y, x, false] # add legal move to moves, 0 represent not capturing
    end
    diagonal.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      next unless y.between?(0, 7) && x.between?(0, 7) && !grid[y][x].nil?

      moves << [y, x, true] # add legal move to moves, true represent capturing
    end
    moves
  end

  private

  def diagonal
    if @type == :black
      [[-1, -1], [-1, 1]]
    else
      [[1, -1], [1, 1]]
    end
  end

  def possible_directions
    if @position == @initial_pos
      if @type == :black
        [[-1, 0], [-2, 0]]
      else
        [[1, 0], [2, 0]]
      end
    elsif @type == :black
      [[-1, 0]]
    else
      [[1, 0]]
    end
  end
end
