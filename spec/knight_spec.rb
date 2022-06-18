require './lib/knight'
require './lib/board'

RSpec.describe Knight do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white knight' do
        knight = Knight.new(:white, [5, 5], board)
        expect(knight.moves).to eq([[4, 7], [6, 7], [4, 3], [6, 3], [3, 4], [3, 6], [7, 4], [7, 6]])
      end

      it 'returns the possible moves of a black knight' do
        knight = Knight.new(:black, [0, 0], board)
        expect(knight.moves).to eq([[1, 2], [2, 1]])
      end
    end
  end
end
