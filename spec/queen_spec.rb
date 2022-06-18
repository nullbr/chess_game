require './lib/queen'
require './lib/board'

RSpec.describe Queen do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white queen' do
        queen = Queen.new(:white, [5, 5], board)
        expect(queen.moves.size).to eq(25)
      end

      it 'returns the possible moves of a black queen' do
        queen = Queen.new(:black, [0, 0], board)
        expect(queen.moves.size).to eq(21)
      end
    end

    context 'there are pieces in the way:' do
      it 'returns the possible moves of a white queen' do
        board = Board.new('bruno', 'giu', true)
        spots = [[4, 4], [4, 5], [4, 6], [6, 4], [6, 5], [6, 6], [5, 4], [5, 6]]
        spots.each { |yx| board.grid[yx[0]][yx[1]] = 'i' }
        queen = Queen.new(:white, [5, 5], board)
        expect(queen.moves.size).to eq(8)
      end
    end
  end
end
