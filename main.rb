require_relative 'lib/chess'

player1 = 'bruno'
player2 = 'giu'
game = Chess.new(player1, player2)

while game.checkmate? == false
  puts 'Check!' if game.check?
  game.to_s
  puts "#{game.current_player[:name]}'s (#{game.current_player[:pieces]}) move:"
  input = gets.chomp
  game.move_piece(input)
  system 'clear'
end

game.to_s
puts 'Checkmate biitches!'
