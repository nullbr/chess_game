require_relative '.bundle/ruby/2.5.0/gems/ruby_figlet-0.6.1/lib/ruby_figlet'
require_relative 'lib/chess'

using RubyFiglet # For String.new(...).art / .art! Moneky Patches

puts 'Chess'.art
puts "\t\t   Bruno Leite"

puts "\nLets Play!"
gets.chomp

player1 = 'bruno'
player2 = 'giu'
game = Chess.new(player1, player2)

while game.checkmate? == false
  puts ''
  game.to_s
  puts "\nCheck!\n" if game.check?
  puts "#{game.current_player[:name]}'s (#{game.current_player[:pieces]}) move:"
  input = gets.chomp
  game.move_piece(input)
  system 'clear'
end

game.to_s
puts 'Checkmate biitches!'
