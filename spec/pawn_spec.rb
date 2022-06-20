require './lib/pawn'
require './lib/board'
require './lib/chess'

RSpec.describe Pawn do
  describe '#moves' do
    context 'returns the possible moves of a white pawn:' do
      board = Board.new('bruno', 'giu', true)
      pawn = Pawn.new(:white, [2, 2], board)

      it 'first move' do
        expect(pawn.moves).to eq([[3, 2], [4, 2]])
      end

      it 'second move' do
        pawn.position(2, 4)
        expect(pawn.moves).to eq([[5, 2]])
      end
    end

    context 'returns the possible moves of a black pawn:' do
      board = Board.new('bruno', 'giu', true)
      pawn = Pawn.new(:black, [6, 2], board)

      it 'first move' do
        expect(pawn.moves).to eq([[5, 2], [4, 2]])
      end

      it 'second move' do
        pawn.position(2, 4)
        expect(pawn.moves).to eq([[3, 2]])
      end
    end

    it "cannot move somewhere there's a piece in" do
      board = Board.new('bruno', 'giu', true)
      board.grid[3][2] = "there's a piece here"
      pawn = Pawn.new(:white, [2, 2], board)
      expect(pawn.moves).to eq([])
    end
  end

  describe '#promoted?' do
    context 'white pawn' do
      it 'returns false if pawn has not reached the end of the board' do
        board = Board.new('bruno', 'giu', true)
        pawn = Pawn.new(:black, [1, 5], board)
        expect(pawn.promoted?).to_not be_truthy
      end

      it 'returns true if pawn has not reached the end of the board' do
        board = Board.new('bruno', 'giu', true)
        pawn = Pawn.new(:black, [0, 5], board)
        expect(pawn.promoted?).to be_truthy
      end
    end

    context 'black pawn' do
      it 'returns false if pawn has not reached the end of the board' do
        board = Board.new('bruno', 'giu', true)
        pawn = Pawn.new(:white, [5, 4], board)
        expect(pawn.promoted?).to_not be_truthy
      end

      it 'returns true if pawn has reached the end of the board' do
        board = Board.new('bruno', 'giu', true)
        pawn = Pawn.new(:white, [7, 4], board)
        expect(pawn.promoted?).to be_truthy
      end
    end
  end

  describe '#en_passant' do
    context 'white pawn' do
      it "moves up two squares in it's first move" do
        game = Chess.new('bruno', 'giu')
        pawn = game.grid[1][6]
        game.move_piece('g4')
        expect(pawn.en_passant).to be_truthy
      end

      it "moves up one square in it's first move" do
        game = Chess.new('bruno', 'giu')
        pawn = game.grid[1][2]
        game.move_piece('c3')
        expect(pawn.en_passant).to_not be_truthy
      end
    end
  end
end
