require './lib/bishop'
require './lib/board'

RSpec.describe Bishop do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white bishop' do
        bishop = Bishop.new(:white, [5, 5], board)
        expect(bishop.moves.size).to eq(11)
      end

      it 'returns the possible moves of a black Bishop' do
        bishop = Bishop.new(:black, [0, 0], board)
        expect(bishop.moves.size).to eq(7)
      end
    end

    context 'there are pieces in the way:' do
      it 'returns the possible moves of a white bishop' do
        board = Board.new('bruno', 'giu', true)
        spots = [[4, 4], [6, 6], [6, 4], [4, 6]]
        spots.each { |yx| board.grid[yx[0]][yx[1]] = 'i' }
        bishop = Bishop.new(:white, [5, 5], board)
        expect(bishop.moves.size).to eq(4)
      end
    end
  end
end
