require './lib/pawn'
require './lib/board'
require './lib/chess'

RSpec.describe Pawn do
  describe '#moves' do
    context 'returns the possible moves of a white pawn:' do
      board = Board.new('bruno', 'giu', true)
      pawn = Pawn.new(:white, [2, 2])
      it 'first move' do
        expect(pawn.moves(board.grid).size).to eq(2)
      end

      it 'second move' do
        pawn.position(2, 4)
        expect(pawn.moves(board.grid).size).to eq(1)
      end

      it 'diagonal move if it can capture' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('a4')
        game.move_piece('b5')
        pawn = game.grid[3][0]
        expect(pawn.moves(game.grid).size).to eq(2)
      end
    end

    context 'returns the possible moves of a black pawn:' do
      board = Board.new('bruno', 'giu', true)
      pawn = Pawn.new(:black, [6, 2])

      it 'first move' do
        expect(pawn.moves(board.grid).size).to eq(2)
      end

      it 'second move' do
        pawn.position(2, 4)
        expect(pawn.moves(board.grid).size).to eq(1)
      end
    end

    it "cannot move somewhere there's a piece in" do
      board = Board.new('bruno', 'giu', true)
      board.grid[3][2] = "there's a piece here"
      pawn = Pawn.new(:white, [2, 2])
      expect(pawn.moves(board.grid)).to eq([])
    end
  end

  describe '#en_passant' do
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

    it 'can capture pawn that is on the side and is en passant' do
    end
  end
end
