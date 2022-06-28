require './lib/chess'
require './lib/ai'

RSpec.describe Bishop do
  describe '#random_move' do
    it 'makes a random, legal move' do
      possible_moves = [5, 0, false], [4, 0, false], [5, 1, false], [4, 1, false], [5, 2, false],
                       [4, 2, false], [5, 3, false], [4, 3, false], [5, 4, false], [4, 4, false],
                       [5, 5, false], [4, 5, false], [5, 6, false], [4, 6, false], [5, 7, false],
                       [4, 7, false], [5, 0, false], [5, 2, false], [5, 5, false], [5, 7, false]
      ai = AI.new
      chess = Chess.new('bruno')
      expect(possible_moves.include?(ai.random_move(chess.all_pieces, chess.grid))).to_not be_nil
    end
  end
end
