require './lib/knight'
require './lib/board'

RSpec.describe Knight do
  describe '#knight_moves' do
    context 'board is empty:' do
      board = Board.new
      it 'returns the possible moves of a white knight' do
        knight = Knight.new(:white, [5, 5], board)
        expect(knight.knight_moves).to eq([[4, 7], [6, 7], [4, 3], [6, 3], [3, 4], [3, 6], [7, 4], [7, 6]])
      end

      it 'returns the possible moves of a black knight' do
        knight = Knight.new(:black, [5, 5], board)
        expect(knight.knight_moves).to eq([[4, 7], [6, 7], [4, 3], [6, 3], [3, 4], [3, 6], [7, 4], [7, 6]])
      end
    end
  end
end
