require './lib/knight'
require './lib/board'

RSpec.describe Pawn do
  describe '#pawn_moves' do
    context 'board is empty:' do
      board = Board.new
      it 'returns the possible moves of a white pawn' do
        pawn = knight.new(:white, [5, 5], board)
        expect(pawn.pawn_moves).to eq([[6, 5], [7, 5], [4, 5], [3, 5]])
      end

      it 'returns the possible moves of a black pawn' do
        pawn = knight.new(:black, [5, 5], board)
        expect(pawn.pawn_moves).to eq([[6, 5], [7, 5], [4, 5], [3, 5]])
      end
    end
  end
end
