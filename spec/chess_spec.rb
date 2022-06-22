require './lib/chess'

# Spec for the chess class tests
RSpec.describe Chess do
  describe '#move_piece' do
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

      it 'white knight to f6' do
        knight = game.grid[0][1]
        game.move_piece('Na3')
        expect(game.grid[2][0]).to eq(knight)
      end
    end

    context 'returns true if it can make a move, false otherwise:' do
      game = Chess.new('bruno', 'giu')
      it 'illegal white king to d6' do
        expect(game.move_piece('Kd6')).to be_falsey
      end

      it 'white pawn to e4' do
        expect(game.move_piece('e4')).to be_truthy
      end

      it 'black pawn to e5' do
        expect(game.move_piece('e5')).to be_truthy
      end

      it 'illegal white pawn to e6' do
        expect(game.move_piece('e6')).to be_falsey
      end

      it 'white bishop to c4' do
        expect(game.move_piece('Bc4')).to be_truthy
      end
    end

    context 'returns true if it can capture a piece:' do
      game = Chess.new('bruno', 'giu')
      it 'pawn capture pawn at a5' do
        game.move_piece('b4')
        game.move_piece('a5')
        expect(game.move_piece('Pxa5')).to be_truthy
      end

      it 'rook capture pawn at a8' do
        expect(game.move_piece('Rxa5')).to be_truthy
      end

      it 'queen capture pawn at a5' do
        game.move_piece('e3')
        game.move_piece('g5')
        game.move_piece('e3')
        game.move_piece('Qg4')
        game.move_piece('d6')
        expect(game.move_piece('Qxc8')).to be_truthy
      end
    end

    context 'returns true if a pawn is promoted:' do
      game = Chess.new('bruno', 'giu')
      game.move_piece('b4')
      game.move_piece('a5')
      game.move_piece('Pxa5')
      game.move_piece('b5')
      game.move_piece('a6')
      game.move_piece('b4')
      game.move_piece('a7')
      game.move_piece('b3')

      it 'white pawn promoted at e8' do
        expect(game.move_piece('axb8=K')).to be_truthy
      end

      it 'black pawn promoted at b1' do
        game.move_piece('b2')
        game.move_piece('Nc3')
        expect(game.move_piece('b1=R')).to be_truthy
      end

      it 'try to promote white pawn at e3' do
        expect(game.move_piece('e3=Q')).to be_falsey
        puts ''
        game.to_s
      end
    end
  end

  describe '#process_input' do
    context 'analyze input and returns an array with info:' do
      game = Chess.new('bruno', 'giu')
      it 'checks axb8=K' do
        expect(game.process_input('axb8=K')).to eq([1, 7, 'P', true, King, 0]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin]
      end

      it 'checks b5' do
        expect(game.process_input('b5')).to eq([1, 4, 'P', false, nil, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin]
      end

      it 'checks Qxc6' do
        expect(game.process_input('Qxc6')).to eq([2, 5, 'Q', true, nil, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin]
      end

      it 'checks exf3' do
        expect(game.process_input('exf3')).to eq([5, 2, 'P', true, nil, 4]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin]
      end

      it 'checks Re4' do
        expect(game.process_input('Re4')).to eq([4, 3, 'R', false, nil, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin]
      end

      it 'checks Bcf4' do
        expect(game.process_input('Bcf4')).to eq([5, 3, 'B', false, nil, 2]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin]
      end
    end
  end
end
