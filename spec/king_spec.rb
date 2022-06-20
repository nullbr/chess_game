require './lib/king'
require './lib/board'

RSpec.describe King do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white king' do
        king = King.new(:white, [5, 5])
        expect(king.moves(board.grid).size).to eq(8)
      end

      it 'returns the possible moves of a black king' do
        king = King.new(:black, [0, 0])
        expect(king.moves(board.grid).size).to eq(3)
      end
    end
  end
end
