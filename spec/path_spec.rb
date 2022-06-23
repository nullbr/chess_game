require './lib/chess'

RSpec.describe Path do
  describe '#shortest_path' do
    game = Chess.new('bruno', 'giu')
    game.move_piece('f3')
    game.move_piece('e5')
    game.move_piece('a3')
    game.move_piece('Qh4')
    it 'returns empty for white pawn from a3 to e8' do
      piece = game.grid[2][0]
      final = [7, 4]
      expect(piece.shortest_path(final, game.grid)).to eq([])
    end

    it 'returns empty for white rook from a1 to a7' do
      piece = game.grid[0][0]
      final = [6, 0]
      expect(piece.shortest_path(final, game.grid)).to eq([])
    end

    it "returns black queen's path from [3, 7] to [0, 4]" do
      piece = game.grid[3][7]
      final = [0, 4]
      expect(piece.shortest_path(final, game.grid)).to eq([[3, 7], [0, 4]])
    end

    it "returns black knight's path from b8 to d1" do
      piece = game.grid[7][1]
      final = [0, 3]
      expect(piece.shortest_path(final, game.grid).size).to eq(6)
    end
  end
end
