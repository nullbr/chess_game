require_relative 'lib/chess'
require 'colorize'

player1 = 'bruno'
player2 = 'giu'
game = Chess.new(player1, player2)

20.times do
  game.to_s
  print 'move'
  input = gets.chomp
  game.move_piece(input)
end
