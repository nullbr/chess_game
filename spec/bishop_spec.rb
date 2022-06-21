require './lib/bishop'
require './lib/board'

RSpec.describe Bishop do
  describe '#moves' do
    context 'board is empty:' do
      board = Board.new('bruno', 'giu', true)
      it 'returns the possible moves of a white bishop' do
        bishop = Bishop.new(:white, [5, 5])
        expect(bishop.moves(board.grid).size).to eq(11)
      end

      it 'returns the possible moves of a black Bishop' do
        bishop = Bishop.new(:black, [0, 0])
        expect(bishop.moves(board.grid).size).to eq(7)
      end

      it 'ommit move to where there is a friendly piece' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('e4')
        bishop = game.grid[0][5]
        expect(bishop.moves(game.grid).size).to eq(5)
      end
    end
  end

  # describe '#capturing' do
  #   context 'for each moves call, a capturing array will be created' do
  #     board = Board.new('bruno', 'giu')
  #     it 'returns the possible moves of a white bishop' do
  #       bishop
  #       expect(bishop.capturing).to eq(11)
  #     end
  #   end
  # end
end
