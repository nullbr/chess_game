require './lib/rook'
require './lib/board'

RSpec.describe Rook do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white rook' do
        rook = Rook.new(:white, [5, 5])
        expect(rook.moves(board.grid).size).to eq(14)
      end

      it 'returns the possible moves of a black rook' do
        rook = Rook.new(:black, [0, 0])
        expect(rook.moves(board.grid).size).to eq(14)
      end
    end

    context 'there are pieces in the way:' do
      it 'returns the possible moves of a white rook' do
        game = Chess.new('bruno', 'giu')
        game.grid[1][0] = nil
        rook = game.grid[0][0]
        expect(rook.moves(game.grid).size).to eq(6)
      end
    end
  end
end
