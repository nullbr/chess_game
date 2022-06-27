# frozen_string_literal: true

require 'yaml'

module ProcessData
  def save_game(game, filename)
    Dir.mkdir('saved') unless Dir.exist?('saved')
    dumpfile = Psych.dump(game)
    File.write(filename, dumpfile)
  end

  # Choose from saved games, return filename if exists, return nil if it does not
  def choose_saved_game
    options = []
    saved_games = Dir.entries('saved')[2..-1]

    saved_games.each_with_index do |filename, idx|
      puts "#{idx}: #{filename}"
      options << idx
    end
    choose_file = yield(options)
    saved_games[choose_file]
  end

  def load_game(filename)
    Psych.load_file(
      filename
    )
  end

  def get_input(lang, options = ' ')
    yield if block_given?
    while true
      input = gets.chomp.strip
      if %w[quit end exit sair].include?(input.downcase)
        puts lang.zero? ? 'Your game was saved,' : 'Seu jogo foi salvo,'
        abort(lang.zero? ? 'Exiting the game...' : 'Saindo do jogo...')

      # prints insturctions
      elsif input.downcase == 'help' || input.downcase == 'ajuda'
        puts help(lang)

        # Check if theres only letters in the string if options are string
      elsif options == ' '
        break

      # Check if string only contains an integer and its the correct type
      elsif options != ' ' && input !~ /\D/
        input = input.to_i
        break if options.include?(input)

        print lang.zero? ? "Options: #{options} " : "Opções: #{options} "
      # Ask for a valid input type
      else
        print lang.zero? ? 'Invalid argument. ' : 'Argumento inválido. '
      end
    end
    input
  end

  def help(lang)
    if lang.zero?
      "\nK: King, Q: Queen, B: Bishop, R: Rook, N: Knight, P: Pawn\n"\
      "x: Capturing, =: Promoting to , +: Check, #: Checkmate\n"\
      "\nHere's a few examples of moves:\n     e4 | Pawn (P ommited) to e4\n    Nc4 | Knight to c4\n   "\
      "Qd7+ | Queen to d7, + representing a check\n  Kxb5# | King captures at b5, # representing a checkmate\n   "\
      "exf6 | Pawn (from column e) captures at f6\n   g8=Q | Pawn (from column f) captures at g7 and gets promoted to a Queen"
    else
      "\nK: Rei, Q: Dama, B: Bispo, R: Torre, N: Cavalo, P: Peão\n"\
      "x: Capturando, =: Promovendo para , +: Check, #: Checkmate\n"\
      "\nAqui estão alguns exemplos de movimentos:\n     e4 | Peão (P omitido) para e4\n    Nc4 | Cavalo para c4\n   "\
      "Qd7+ | Dama para d7, + representando um xeque\n  Kxb5# | Rei captura em b5, # representando um checkmate\n   "\
      "exf6 | Peão (da coluna e) captura em f6\n   g8=Q | Peão para g8 e é promovido a Dama"
    end
  end
end
