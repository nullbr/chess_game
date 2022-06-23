# frozen_string_literal: true

require_relative 'path'

class Pieces
  include Path

  attr_reader :unicode, :type, :parent, :children
  attr_accessor :notation

  def initialize(type, position)
    @type = type
    @position = position
    @notation = nil
    @parent = nil
    @children = []
    @@history = [position]
  end

  def possible_moves
    directions = possible_directions
    moves = []
    directions.each do |direction|
      x = @position[0] + direction[0]
      y = @position[1] + direction[1]
      moves << [x, y] if x.between?(0, 7) && y.between?(0, 7) && !@@history.include?([x, y])
    end
    moves
  end

  def set_parent(parent)
    @parent = parent
  end

  # takes a position as an array and returns the new position
  def position(x = nil, y = nil)
    @first_move = @position == @initial_pos
    @position = x.nil? ? @position : [y, x]
  end

  def moves(grid)
    directions = possible_directions
    moves = []
    directions.each do |direction|
      y = @position[0] + direction[0]
      x = @position[1] + direction[1]
      next unless y.between?(0, 7) && x.between?(0, 7)

      grid[y][x].nil? ? (moves << [y, x, false]) : (moves << [y, x, true]) # add legal move to moves, 0 represent not capturing
    end
    moves
  end
end
