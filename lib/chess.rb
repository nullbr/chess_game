# frozen_string_literal: true

require_relative 'board'

# main driver class frot the chess game
class Chess < Board
  def initialize(player1, player2 = nil)
    super(player1, player2)
  end
end

game = Chess.new('bruno')

game.to_s