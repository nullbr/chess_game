# frozen_string_literal: true

# Artificial Inteligence
class AI
  attr_accessor :name

  def initialize(difficulty)
    @difficulty = difficulty # 0 = super easy, 1 = easy
    @name = 'Machine'
  end

  def move(pieces, grid)
    @pieces = pieces
    @grid = grid
    if @difficulty.zero?
      move = select_random
    elsif @difficulty == 1
      move = select_capturing(:black)
      move = move.empty? ? select_random : move.sample
    elsif @difficulty == 2
      move = select_defense.sample
    end

    translate(move) unless move.nil?
  end

  private

  # returns array of all moves pieces can make
  def possible_moves(color = :black)
    possible_moves = []
    @pieces[color].each do |piece|
      moves = piece.moves(@grid)
      possible_moves += moves.map { |move| move + [piece] } unless moves.empty?
    end

    possible_moves
  end

  def translate(move)
    y = move[0] + 1
    x = (move[1] + 97).chr
    capturing = move[2] ? 'x' : ''
    if move[3].notation == 'P'
      notation = x_origin = ''
    else
      notation = move[3].notation
      x_origin = (move[3].position[1] + 97).chr
    end
    "#{notation}#{x_origin}#{capturing}#{x}#{y}"
  end

  # return a sample move
  def select_random
    possible_moves(:black).sample
  end

  # choose move, select one with capturing if available
  def select_capturing(color)
    moves = possible_moves(color)
    can_capture = capturing(moves)
    
    king_pos = capture_king(moves)
    king_pos.empty? ? can_capture : king_pos
  end

  # return kings position if it is available, return empty otherwise
  def capture_king(moves)
    moves.select { |move| @grid[move[0]][move[1]].instance_of?(King) }
  end

  # return all pieces that can capture
  def capturing(moves)
    moves.select { |move| move[2] == true }
  end

  # return array with possible defensive moves
  def defensive_moves(attacker, defending_piece)
    defending_moves = []
    @pieces[:black].each do |piece|
      moves = piece.defend(attacker, defending_piece, @grid)
      defending_moves << moves unless moves.empty?
    end

    defending_moves.flatten(1)
  end
  
  def select_defense
    # importance = { 'P': 0, 'B': 1, 'N': 2, 'R': 3, 'Q': 4, 'K': 5 }
    enemy_capture = select_capturing(:white)
    return [] if enemy_capture.empty?

    defending_piece = enemy_capture.map { |cap| @grid[cap[0]][cap[1]] }[0]
    attacker = enemy_capture[0][3]
    defensive_moves(attacker, defending_piece)
  end
end
