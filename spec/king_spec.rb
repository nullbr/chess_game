require './lib/king'
require './lib/board'

RSpec.describe King do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white king' do
        king = King.new(:white, [5, 5])
        expect(king.moves(board.grid)).to eq([[4, 4], [4, 5], [4, 6], [6, 4], [6, 5], [6, 6], [5, 4], [5, 6]])
      end

      it 'returns the possible moves of a black king' do
        king = King.new(:black, [0, 0])
        expect(king.moves(board.grid)).to eq([[1, 0], [1, 1], [0, 1]])
      end
    end
  end
end
