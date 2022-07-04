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
      move = select_defense
      move = select_capturing(:black).sample if move.nil? || move.empty?
      move = select_random if move.nil? || move.empty?
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

  def select_defense
    defend_attack = most_important
    return [] if defend_attack.nil?

    moves = defensive_moves(defend_attack[0], defend_attack[1])

    moves.empty? ? moves : best_move(moves, defend_attack)
  end

  # returns the best move
  # 1 -> Capture attacker
  # 2 -> Move out of the way
  # 3 -> Sacrifice piece
  def best_move(moves, pieces)
    best = []
    moves.each do |move|
      return move if move[2] # capturing is true

      if move[3] != pieces[0]
        # sacrifice: piece used to defend is different than defending piece
        best << move
      else
        best = [move] + best
      end
    end
    best[0]
  end

  # return array with possible defensive moves
  def defensive_moves(defending_piece, attacker)
    defending_moves = []
    @pieces[:black].each do |piece|
      moves = piece.defend(attacker, defending_piece, @grid)
      defending_moves << moves unless moves.empty?
    end

    defending_moves.flatten(1)
  end

  def most_important
    enemy_capture = select_capturing(:white)
    return if enemy_capture.empty?

    defending_pieces = {}
    enemy_capture.each do |cap|
      piece = @grid[cap[0]][cap[1]]
      defending_pieces[piece.rank] = [piece] + [cap[3]] # defending + attacking piece
    end
    defending_pieces.max[1]
  end
end
