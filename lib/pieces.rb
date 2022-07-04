# frozen_string_literal: true

require_relative 'path'
require 'pry'

class Pieces
  include Path

  attr_reader :unicode, :type, :rank
  attr_accessor :notation, :children

  def initialize(type, position)
    @type = type
    @position = position
    @parent = nil
    @children = []
  end

  def parent(parent = nil)
    @parent = parent.nil? ? @parent : parent
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
      next unless y.between?(0, 7) && x.between?(0, 7) && @position != [y, x]

      destination = grid[y][x]
      if !destination.nil?
        moves << [y, x, true] unless destination.type == @type
      else
        moves << [y, x, false] # add legal move to moves, true represent not capturing
      end
    end
    moves
  end

  # return array with defending moves if piece can defend itself
  # defending move ex: [y(defend), x(defend), capturing, piece_used_to_defend]
  def defend(attacker, defending, grid)
    return [] if rank > defending.rank

    moves = self.moves(grid)
    path = blocks_in_path(attacker, defending)
    if defending == self
      defending_moves = moves.reject { |move| path.include?(move[0..1]) }
      moves.each { |move| defending_moves << move if move[0..1] == attacker.position }
    else
      defending_moves = moves.select { |move| path.include?(move[0..1]) }
    end

    defending_moves.nil? ? [] : defending_moves.map { |move| move + [self] }
  end
end
