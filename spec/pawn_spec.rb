require './lib/pawn'
require './lib/board'

RSpec.describe Pawn do
  describe '#pawn_moves' do
    context 'returns the possible moves of a white pawn:' do
      board = Board.new
      pawn = Pawn.new(:white, [2, 2], board)

      it 'first move' do
        expect(pawn.pawn_moves).to eq([[3, 2], [4, 2]])
      end

      it 'second move' do
        pawn.position = [4, 2]
        expect(pawn.pawn_moves).to eq([[5, 2]])
      end
    end

    context 'returns the possible moves of a black pawn:' do
      board = Board.new
      pawn = Pawn.new(:black, [6, 2], board)

      it 'first move' do
        expect(pawn.pawn_moves).to eq([[5, 2], [4, 2]])
      end

      it 'second move' do
        pawn.position = [4, 2]
        expect(pawn.pawn_moves).to eq([[3, 2]])
      end
    end

    it "cannot move somewhere there's a piece in" do
      board = Board.new
      board.grid[3][2] = "there's a piece here"
      pawn = Pawn.new(:white, [2, 2], board)
      expect(pawn.pawn_moves).to eq([])
    end
  end

  describe '#promoted?' do
    context 'white pawn' do
      it 'returns false if pawn has not reached the end of the board' do
        board = Board.new
        pawn = Pawn.new(:black, [1, 5], board)
        expect(pawn.pawn_moves).to_not be_truthy
      end

      it 'returns true if pawn has not reached the end of the board' do
        board = Board.new
        pawn = Pawn.new(:black, [0, 5], board)
        expect(pawn.pawn_moves).to be_truthy
      end
    end

    context 'black pawn' do
      it 'returns false if pawn has not reached the end of the board' do
        board = Board.new
        pawn = Pawn.new(:white, [5, 4], board)
        expect(pawn.pawn_moves).to be_truthy
      end

      it 'returns true if pawn has reached the end of the board' do
        board = Board.new
        pawn = Pawn.new(:white, [7, 4], board)
        expect(pawn.pawn_moves).to be_truthy
      end
    end
  end
end
