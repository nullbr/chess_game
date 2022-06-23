require './lib/chess'

RSpec.describe Path do
  describe '#shortest_path' do
    it 'returns the path from [3, 7] to [0, 4]' do
      game = Chess.new('bruno', 'giu')
      game.move_piece('f3')
      game.move_piece('e5')
      game.move_piece('a3')
      game.move_piece('Qh4')
      piece = game.grid[3][7]
      final = [0, 4]
      expect(piece.shortest_path(final, game.grid)).to eq([0, 4])
    end
  end
end
