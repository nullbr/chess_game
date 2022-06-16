require './lib/king'
require './lib/board'

RSpec.describe King do
  describe '#king_moves' do
    context 'board is empty:' do
      board = Board.new
      it 'returns the possible moves of a white king' do
        king = King.new(:white, [5, 5], board)
        expect(king.king_moves).to eq([[4, 4], [4, 5], [4, 6], [6, 4], [6, 5], [6, 6], [5, 4], [5, 6]])
      end

      it 'returns the possible moves of a black king' do
        king = King.new(:black, [0, 0], board)
        expect(king.king_moves).to eq([[1, 0], [1, 1], [0, 1]])
      end
    end
  end
end
