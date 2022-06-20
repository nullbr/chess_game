require './lib/knight'
require './lib/board'

RSpec.describe Knight do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white knight' do
        knight = Knight.new(:white, [5, 5])
        expect(knight.moves(board.grid).size).to eq(8)
      end

      it 'returns the possible moves of a black knight' do
        knight = Knight.new(:black, [0, 0])
        expect(knight.moves(board.grid).size).to eq(2)
      end
    end
  end
end
