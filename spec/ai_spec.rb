require './lib/chess'
require './lib/ai'

RSpec.describe Bishop do
  describe '#random_move' do
    it 'makes a random, legal move' do
      ai = AI.new
      chess = Chess.new('bruno')
      chess.next_player
      puts ai.random_move(chess.all_pieces, chess.grid)
      expect(chess.move_piece(ai.random_move(chess.all_pieces, chess.grid))).to be_truthy
      chess.to_s
    end
  end
end
