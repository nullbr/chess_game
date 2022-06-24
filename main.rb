require_relative '.bundle/ruby/2.5.0/gems/ruby_figlet-0.6.1/lib/ruby_figlet'
require_relative 'lib/chess'
require_relative 'lib/process_data'

using RubyFiglet # For String.new(...).art / .art! Moneky Patches
include ProcessData

puts 'Chess'.art
puts "\t\t   Bruno Leite"
puts "\nLets Play!"

lang = get_input(lang, [0, 1]) { puts "What language would you like to play in?\n0: English\n1: Português" }

if Dir.exist?('saved') && Dir.entries('saved').size > 2
  if lang.zero?
    puts "\n0: to start a new game \n1: to load a game"
  else
    puts "\n0: Começar um novo jogo.\n1: Carregar jogo salvo"
  end
  choice = get_input(lang, [0, 1])
else
  choice = 0
end

# Start a new game
if choice.zero?
  puts lang.zero? ? "\nName of Player 1" : "\nNome do jogador 1"
  player1 = get_input(lang)

  puts lang.zero? ? "\nName of Player 2" : "\nNome do jogador 2"
  player2 = get_input(lang)

  game = Chess.new(player1, player2)
  system 'clear'

  # Set new file to be used for saving the game
  time = Time.now.strftime('%Hh%M-%d-%m-%Y')
  filename = "saved/#{player1}-#{player2}-#{time}.yaml"

# Load a game from saved games
else
  if lang.zero?
    puts "Getting saved games...\nChoose from saved games: "
  else
    puts "Carregando jogos....\nEscolha um dos jogos salvos: "
  end
  filename = choose_saved_game { |game_options| get_input(lang, game_options) }
  filename = "saved/#{filename}"
  game = load_game(filename)

  system 'clear'
end

while game.checkmate? == false
  puts ''
  game.to_s
  puts "\nCheck!\n" if game.check?
  puts "#{game.current_player[:name]}'s (#{game.current_player[:pieces]}) move:"
  input = get_input(lang)
  game.move_piece(input)
  save_game(game, filename)
  system 'clear'
end

File.delete(filename) if File.exist?(filename)
puts 'Checkmate!'
puts "#{game.next_player} won!"
