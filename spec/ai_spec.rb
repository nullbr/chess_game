require './lib/chess'
require './lib/ai'

RSpec.describe Bishop do
  describe '#random_move' do
    chess = Chess.new('bruno')
    it 'makes a random, legal move' do
      ai = AI.new(0)
      chess.next_player
      expect(chess.move_piece(ai.move(chess.all_pieces, chess.grid))).to be_truthy
    end

    it 'makes a random move selecting capturing' do
      ai = AI.new(1)
      chess.next_player
      expect(chess.move_piece(ai.move(chess.all_pieces, chess.grid))).to be_truthy
    end

    it 'makes a random move selecting king if available' do
      ai = AI.new(1)
      game = Chess.new('bruno', ai)
      game.move_piece('f3')
      game.move_piece('e5')
      game.move_piece('a3')
      game.move_piece('Qh4')
      game.move_piece('b3')
      puts ''
      game.to_s
      expect(ai.move(game.all_pieces, game.grid)).to eq('Qhxe1')
    end

    it 'pawn deffends king' do
      ai = AI.new(2)
      game = Chess.new('bruno', ai)
      game.move_piece('e4')
      game.move_piece('f6')
      game.move_piece('a6')
      game.move_piece('e3')
      game.move_piece('a7')
      game.move_piece('Qh5')
      puts ''
      game.to_s
      expect(ai.move(game.all_pieces, game.grid)).to eq('g6')
    end
  end
end
