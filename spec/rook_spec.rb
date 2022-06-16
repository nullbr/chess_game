require './lib/rook'
require './lib/board'

RSpec.describe Rook do
  describe '#rook_moves' do
    context 'board is empty:' do
      board = Board.new
      it 'returns the possible moves of a white rook' do
        rook = Rook.new(:white, [5, 5], board)
        expect(rook.rook_moves.size).to eq(14)
      end

      it 'returns the possible moves of a black rook' do
        rook = Rook.new(:black, [0, 0], board)
        expect(rook.rook_moves.size).to eq(14)
      end
    end

    context 'there are pieces in the way:' do
      it 'returns the possible moves of a white rook' do
        board = Board.new
        spots = [[4, 5], [5, 4], [6, 5], [5, 6]]
        spots.each { |yx| board.grid[yx[0]][yx[1]] = 'i' }
        rook = Rook.new(:white, [5, 5], board)
        expect(rook.rook_moves.size).to eq(4)
      end
    end
  end
end
