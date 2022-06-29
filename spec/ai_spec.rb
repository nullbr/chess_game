require './lib/chess'
require './lib/ai'

RSpec.describe Bishop do
  describe '#random_move' do
    chess = Chess.new('bruno')
    it 'makes a random, legal move' do
      ai = AI.new(0)
      chess.next_player
      expect(chess.move_piece(ai.random_move(chess.all_pieces, chess.grid))).to be_truthy
    end

    it 'makes a random move selecting capturing' do
      ai = AI.new(1)
      chess.next_player
      expect(chess.move_piece(ai.random_move(chess.all_pieces, chess.grid))).to be_truthy
    end
  end
end
