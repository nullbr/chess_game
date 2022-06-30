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
    @moves = possible_moves
    if @difficulty.zero?
      move = select_random
    elsif @difficulty == 1
      move = select_capturing
    end

    translate(move) unless move.nil?
  end

  private

  # returns array of all moves pieces can make
  def possible_moves(type = :black)
    possible_moves = []
    @pieces[type].each do |piece|
      moves = piece.moves(@grid)
      possible_moves += moves.map { |move| move + [piece.notation] + [piece.position[1]] } unless moves.empty?
    end

    possible_moves
  end

  # grabs x
  def translate(move)
    y = move[0] + 1
    x = (move[1] + 97).chr
    capturing = move[2] ? 'x' : ''
    if move[3] == 'P'
      notation = x_origin = ''
    else
      notation = move[3]
      x_origin = (move[4] + 97).chr
    end
    "#{notation}#{x_origin}#{capturing}#{x}#{y}"
  end

  # return a sample move
  def select_random
    @moves.sample
  end

  # choose move, select one with capturing if available
  def select_capturing
    can_capture = capturing
    return select_random if can_capture.empty?

    king_pos = capture_king
    king_pos.empty? ? can_capture.sample : king_pos
  end
  
  # return kings position if it is available, return empty otherwise
  def capture_king
    @moves.each { |move| return move if @grid[move[0]][move[1]].instance_of?(King) }
  end
  
  # return all pieces that can capture
  def capturing
    @moves.select { |move| move[2] == true }
  end

  def select_defense
    possible_capture = []
    
    importance = { 'P': 0, 'B': 1, 'N': 2, 'R': 3, 'Q': 4, 'K': 5 }
    # @pieces[:black].each { |piece| current_posistions << piece.position + [importance[piece.notation]] }
    possible_moves(:white).each { || }

  end
end
