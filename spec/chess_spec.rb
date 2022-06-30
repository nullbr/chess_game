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

    context 'checks that correct piece gets moved to the position:' do
      game = Chess.new('bruno', 'giu')
      it 'bug 1, pawn moves back' do
        moves = %w[a3 d6 h4 g6 b4 Nc6 c3 f5 d4 Nf6 e3 Ng4
                   g3 d5 f3 e5 Ra2 a5 bxa5 Rxa5 Rh2 Rxa3]
        moves.each { |move| game.move_piece(move) }
        expect(game.move_piece('cb2')).to be_falsey # moves pawn to invealid location
      end

      it 'bug 2, causes infinite loop' do
        moves = %w[Bb2 exd4 c4 Nb4 e4 Nc2]
        moves.each { |move| game.move_piece(move) }
        expect(game.checkmate?).to be_falsey # moves knight into check and causes an infinite loop
      end

      it 'bug 3, causes infinite loop' do
        game2 = Chess.new('bruno', 'giu')
        moves = %w[b4 e5 Nc3 g5 d4 exd4 g4 Ke7 e3 a6 exd4]
        moves.each { |move| game2.move_piece(move) }
        expect(game2.checkmate?).to be_falsey
      end

      it 'bug 4, does not recognize checkmate if king is captured' do
        game3 = Chess.new('bruno', 'giu')
        moves = %w[e4 f5 exf5 e6 f6 Ke7 fxe7]
        moves.each { |move| game3.move_piece(move) }
        puts 'hellooooo'
        game3.to_s
        expect(game3.checkmate?).to be_truthy # moves knight into check and causes an infinite loop
      end

      it 'bug 5, runs into infinite loop' do
        game4 = Chess.new('bruno', 'giu')
        moves = %w[a3 d6 h4 g6 b4 Nc6 c3 f5 d4 Nf6 e3 Ng4 g3 d5 f3 e5 Ra2 a5 bxa5 Rxa5 Rh2 Rxa3 Bb2 exd4 cxd4 Nb4 Ra8 Nc2]
        moves.each { |move| game4.move_piece(move) }
        expect(game4.checkmate?).to be_falsey
      end

      it 'bug 6, runs into infinite loop' do
        game5 = Chess.new('bruno', 'giu')
        moves = %w[b4 e5 Nc3 g5 d4 exd4 g4 Ke7 e4 a6 b5 Kf6 Qf3+ d5]
        moves.each { |move| game5.move_piece(move) }
        expect(game5.checkmate?).to be_falsey
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
      end
    end
  end

  describe '#process_input' do
    context 'analyze input and returns an array with info:' do
      game = Chess.new('bruno', 'giu')
      it 'checks axb8=K' do
        expect(game.process_input('axb8=K')).to eq([1, 7, 'P', true, King, 0, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'checks b5' do
        expect(game.process_input('b5')).to eq([1, 4, 'P', false, nil, nil, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'checks Qxc6' do
        expect(game.process_input('Qxc6')).to eq([2, 5, 'Q', true, nil, nil, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'checks exf3' do
        expect(game.process_input('exf3')).to eq([5, 2, 'P', true, nil, 4, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'checks Re4' do
        expect(game.process_input('Re4')).to eq([4, 3, 'R', false, nil, nil, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'checks Bcf4' do
        expect(game.process_input('Bcf4')).to eq([5, 3, 'B', false, nil, 2, nil]) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'process Kxc5 with check' do
        expect(game.process_input('Kxc5+')).to eq([2, 4, 'K', true, nil, nil, '+']) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'Nh3 with check' do
        expect(game.process_input('Nh3+')).to eq([7, 2, 'N', false, nil, nil, '+']) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'Kexf4# with checkmate' do
        expect(game.process_input('Kexf4#')).to eq([5, 3, 'K', true, nil, 4, '#']) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'invalid input' do
        expect(game.process_input('Kexf4#9')).to eq(nil) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end

      it 'Kexf4# with checkmate' do
        expect(game.process_input('t')).to eq(nil) # [x_dest, y_dest, notation, capturing, promoting_to, y or x_origin, check]
      end
    end
  end

  describe '#check' do
    context '@check = true if move puts king in check:' do
      it 'check' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('f3')
        game.move_piece('e5')
        game.move_piece('a3')
        game.move_piece('Qh4')
        expect(game.check?).to be_truthy
      end
    end
  end

  describe '#checkmate' do
    context 'true if move causes checkmate:' do
      it 'check, but rook can defend, returns false' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('f3')
        game.move_piece('e5')
        game.move_piece('g4')
        game.move_piece('a6')
        game.move_piece('h4')
        game.move_piece('Qxh4')
        expect(game.checkmate?).to be_falsey
      end

      it 'fastest checkmate' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('f3')
        game.move_piece('e5')
        game.move_piece('g4')
        game.move_piece('Qh4')
        expect(game.checkmate?).to be_truthy
      end

      it 'check, but not a checkmate, returns false' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('f3')
        game.move_piece('e5')
        game.move_piece('a3')
        game.move_piece('Qh4')
        expect(game.checkmate?).to be_falsey
      end

      it 'check, but king can defend, returns false' do
        game = Chess.new('bruno', 'giu')
        game.move_piece('f3')
        game.move_piece('e5')
        game.move_piece('g4')
        game.move_piece('Na6')
        game.move_piece('e3')
        game.move_piece('Qh4')
        expect(game.checkmate?).to be_falsey
      end
    end
  end
end
