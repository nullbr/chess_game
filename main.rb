require_relative '.bundle/ruby/2.5.0/gems/ruby_figlet-0.6.1/lib/ruby_figlet'
require_relative 'lib/chess'
require_relative 'lib/process_data'
require_relative 'lib/ai'

using RubyFiglet # For String.new(...).art / .art! Moneky Patches
include ProcessData

puts 'Chess'.art
puts "\t\t   Bruno Leite"
puts "\nLets Play!"

puts "What language would you like to play in?\n0: English\n1: Português"
lang = get_input(0, [0, 1])

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
  puts lang.zero? ? "\n0: Human vs Human\n1: Human vs AI" : "\n0: Humano vs Humano\n1: Humano vs AI"
  game_type = get_input(lang, [0, 1])

  if game_type == 1
    puts lang.zero? ? "Difficulty\n0: Super Easy\n1: Easy" : "\nDificuldade\n0: Super Fácil\n1: Fácil"
    difficulty = get_input(lang, [0, 1])
  end

  puts lang.zero? ? "\nName of Player 1" : "\nNome do jogador 1"
  player1 = get_input(lang)

  if game_type.zero?
    puts lang.zero? ? "\nName of Player 2" : "\nNome do jogador 2"
    player2 = get_input(lang)
  else
    player2 = AI.new(difficulty)
  end

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
  puts "Moves: #{game.all_moves.join(', ')}"
  print lang.zero? ? 'Captures: ' : 'Capturados: '

  game.captured.each do |capture|
    print "#{capture.class}(#{capture.type})"
    print ', ' unless capture == game.captured[-1]
  end
  puts ''

  puts "\nCheck!" if game.check?
  
  if game.current_player[:name].instance_of?(AI)
    print 'Machine move: '
    input = game.machine.choose_move(game.all_pieces, game.grid)
    print input
    sleep 2
  else
    print "\n#{game.current_player[:name]} (#{game.current_player[:pieces]}) move "
    print lang.zero? ? "('help' for instructions): " : '("ajuda" para instruções): '
    input = get_input(lang)
  end

  game.move_piece(input)
  save_game(game, filename)
  system 'clear'
end

File.delete(filename) if File.exist?(filename)

game.to_s
puts 'Checkmate!'
puts "#{game.next_player[:name]} won!"
