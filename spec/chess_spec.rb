require './lib/chess'

# Spec for the chess class tests
RSpec.describe Chess do
  describe "#move_piece" do
    context 'move piece to a specified position:' do
      game = Chess.new('bruno', 'giu')
      it 'white pawn to d3' do
        pawn = game.grid[1][3]
        game.move_piece('d3')
        expect(game.grid[2][3]).to eq(pawn)
      end

      it 'black pawn to g5' do
        pawn = game.grid[6][6]
        game.move_piece('g5')
        expect(game.grid[4][6]).to eq(pawn)
      end

      it 'black knight to f6' do
        knight = game.grid[7][6]
        game.move_piece('Kf6')
        expect(game.grid[4][6]).to eq(knight)
      end
    end
  end
end
