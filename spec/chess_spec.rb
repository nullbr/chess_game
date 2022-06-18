require './lib/chess'

# Spec for the chess class tests
RSpec.describe Chess do
  describe "#move_piece" do
    context 'move piece to a specified position:' do
      game = Chess.new('bruno', 'giu')
      it 'moves white pawn to c3' do
        pawn = game.grid[1][2]
        game.move_piece('c3')
        expect(pawn.position).to eq([2, 2])
      end

      it 'moves black pawn to g5' do
        pawn = game.grid[6][5]
        game.move_piece('g5')
        game.to_s
        expect(pawn.position).to eq([4, 6])
      end
    end
  end
end
