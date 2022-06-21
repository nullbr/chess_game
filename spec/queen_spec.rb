require './lib/queen'
require './lib/board'

RSpec.describe Queen do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white queen' do
        queen = Queen.new(:white, [5, 5])
        expect(queen.moves(board.grid).size).to eq(25)
      end

      it 'returns the possible moves of a black queen' do
        queen = Queen.new(:black, [0, 0])
        expect(queen.moves(board.grid).size).to eq(21)
      end
    end

    context 'there are pieces in the way:' do
      it 'ommit move to where there is a friendly piece' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('d4')
        queen = game.grid[0][3]
        expect(queen.moves(game.grid).size).to eq(2)
      end

      it 'ommit move to where there is a friendly piece' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('e3')
        queen = game.grid[0][3]
        expect(queen.moves(game.grid).size).to eq(4)
      end
    end
  end
end
