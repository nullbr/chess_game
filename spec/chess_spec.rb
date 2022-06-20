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
        game.move_piece('Nf6')
        game.to_s
        expect(game.grid[5][5]).to eq(knight)
      end
    end

    context 'returns true if it can make a move, false otherwise:' do
      game = Chess.new('bruno', 'giu')
      it 'king to d6' do
        expect(game.move_piece('Kd6')).to be_falsey
      end

      it 'king to d6' do
        expect(game.move_piece('e4')).to be_truthy
      end
    end
  end
end
