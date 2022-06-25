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
      filename,
      )
  end

  def get_input(lang, options = ' ')
    yield if block_given?
    while true
      input = gets.chomp.strip
      if %w[quit end exit sair].include?(input.downcase)
        puts lang.zero? ? 'Your game was saved,' : 'Seu jogo foi salvo,'
        abort(lang.zero? ? 'Exiting the game...' : 'Saindo do jogo...')

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
        print lang.zero? ? 'Enter a valid. ' : 'Insira opção válida. '
      end
    end
    input
  end
end
