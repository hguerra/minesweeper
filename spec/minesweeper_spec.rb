require 'spec_helper'

RSpec.describe Engine::Minesweeper do
  before(:each) do
    @minesweeper = Engine::Minesweeper.new(4, 4, 5, Random.new(1234))
  end

  after(:each) do
    @minesweeper = nil
  end

  describe '#play' do
    context 'when user clicked twice the same cell' do
      it 'should return false' do
        expect(@minesweeper.play(2, 1)).to be_truthy
        expect(@minesweeper.play(2, 1)).to be_falsey
      end
    end

    context 'when user clicked on a cell that was discovered because their neighbors has no mines' do
      it 'should return false' do
        expect(@minesweeper.play(1, 4)).to be_truthy
        expect(@minesweeper.play(2, 4)).to be_falsey
      end
    end

    context 'when user clicked on a cell that has a flag' do
      it 'should return false' do
        expect(@minesweeper.flag(1, 1)).to be_truthy
        expect(@minesweeper.play(1, 1)).to be_falsey
      end
    end

    context 'when user clicked in all cells with no mines' do
      it 'should return true' do
        expect(@minesweeper.play(2, 1)).to be_truthy
        expect(@minesweeper.play(3, 1)).to be_truthy
        expect(@minesweeper.play(4, 1)).to be_truthy

        expect(@minesweeper.play(2, 2)).to be_truthy

        expect(@minesweeper.play(1, 3)).to be_truthy
        expect(@minesweeper.play(2, 3)).to be_truthy
        expect(@minesweeper.play(3, 3)).to be_truthy
        expect(@minesweeper.play(4, 3)).to be_truthy

        expect(@minesweeper.play(1, 4)).to be_truthy
      end
    end
  end

  describe '#flag' do
    context 'when user put a flag on a cell that was discovered' do
      it 'should return false' do
        expect(@minesweeper.play(2, 3)).to be_truthy
        expect(@minesweeper.flag(2, 3)).to be_falsey
      end
    end

    context 'when user put a flag in all cells with no mines' do
      it 'should return true' do
        expect(@minesweeper.flag(1, 1)).to be_truthy
        expect(@minesweeper.flag(1, 2)).to be_truthy
        expect(@minesweeper.flag(3, 2)).to be_truthy
        expect(@minesweeper.flag(4, 2)).to be_truthy
        expect(@minesweeper.flag(3, 4)).to be_truthy
      end
    end

    context 'when user remove a flag' do
      it 'should return true' do
        expect(@minesweeper.flag(2, 1)).to be_truthy
        expect(@minesweeper.play(2, 1)).to be_falsey

        expect(@minesweeper.flag(2, 1)).to be_truthy
        expect(@minesweeper.play(2, 1)).to be_truthy
      end
    end
  end

  describe '#still_playing?' do
    context 'before lose or win' do
      it 'should return true' do
        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(2, 2)).to be_truthy
        expect(@minesweeper.still_playing?).to be_truthy
      end
    end

    context 'after lose' do
      it 'should return false' do
        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(2, 2)).to be_truthy
        expect(@minesweeper.still_playing?).to be_truthy

        expect(@minesweeper.play(1, 1)).to be_truthy
        expect(@minesweeper.still_playing?).to be_falsey
      end
    end

    context 'after win' do
      it 'should return false' do
        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.flag(1, 1)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.flag(1, 2)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.flag(3, 2)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.flag(4, 2)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.flag(3, 4)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(2, 1)).to be_truthy
        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(3, 1)).to be_truthy
        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(4, 1)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(2, 2)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(1, 3)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(2, 3)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(3, 3)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(4, 3)).to be_truthy

        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.play(1, 4)).to be_truthy

        expect(@minesweeper.still_playing?).to be_falsey
      end
    end
  end

  describe '#victory?' do
    context 'before lose or win' do
      it 'should return false' do
        expect(@minesweeper.victory?).to be_falsey
        expect(@minesweeper.play(2, 2)).to be_truthy
        expect(@minesweeper.victory?).to be_falsey
      end
    end

    context 'after lose' do
      it 'should return false' do
        expect(@minesweeper.victory?).to be_falsey
        expect(@minesweeper.play(2, 2)).to be_truthy
        expect(@minesweeper.victory?).to be_falsey

        expect(@minesweeper.play(1, 1)).to be_truthy
        expect(@minesweeper.still_playing?).to be_falsey
        expect(@minesweeper.victory?).to be_falsey
      end
    end

    context 'after win' do
      it 'should return false' do
        expect(@minesweeper.still_playing?).to be_truthy
        expect(@minesweeper.flag(1, 1)).to be_truthy
        expect(@minesweeper.flag(1, 2)).to be_truthy
        expect(@minesweeper.flag(3, 2)).to be_truthy
        expect(@minesweeper.flag(4, 2)).to be_truthy
        expect(@minesweeper.flag(3, 4)).to be_truthy

        expect(@minesweeper.play(2, 1)).to be_truthy
        expect(@minesweeper.play(3, 1)).to be_truthy
        expect(@minesweeper.play(4, 1)).to be_truthy
        expect(@minesweeper.play(2, 2)).to be_truthy
        expect(@minesweeper.play(1, 3)).to be_truthy
        expect(@minesweeper.play(2, 3)).to be_truthy
        expect(@minesweeper.play(3, 3)).to be_truthy
        expect(@minesweeper.play(4, 3)).to be_truthy
        expect(@minesweeper.play(1, 4)).to be_truthy

        expect(@minesweeper.still_playing?).to be_falsey
        expect(@minesweeper.victory?).to be_truthy
      end
    end
  end

  describe '#board_state' do
    it 'should return a BoardState' do
      expect(@minesweeper.board_state).to be_a Engine::BoardState
    end

    it 'should return a BoardState and a warning' do
      expect(@minesweeper.board_state).to be_a Engine::BoardState
      expect { @minesweeper.board_state({xray: true}) }.to output("Warning: Argument 'xray' is valid only if the game is finished.\n").to_stderr
    end

    it 'should return a BoardState' do
      expect(@minesweeper.board_state).to be_a Engine::BoardState

      expect(@minesweeper.still_playing?).to be_truthy
      expect(@minesweeper.flag(1, 1)).to be_truthy
      expect(@minesweeper.flag(1, 2)).to be_truthy
      expect(@minesweeper.flag(3, 2)).to be_truthy
      expect(@minesweeper.flag(4, 2)).to be_truthy
      expect(@minesweeper.flag(3, 4)).to be_truthy

      expect(@minesweeper.play(2, 1)).to be_truthy
      expect(@minesweeper.play(3, 1)).to be_truthy
      expect(@minesweeper.play(4, 1)).to be_truthy
      expect(@minesweeper.play(2, 2)).to be_truthy
      expect(@minesweeper.play(1, 3)).to be_truthy
      expect(@minesweeper.play(2, 3)).to be_truthy
      expect(@minesweeper.play(3, 3)).to be_truthy
      expect(@minesweeper.play(4, 3)).to be_truthy
      expect(@minesweeper.play(1, 4)).to be_truthy

      expect(@minesweeper.still_playing?).to be_falsey
      expect(@minesweeper.victory?).to be_truthy

      expect(@minesweeper.board_state({xray: true})).to be_a Engine::BoardState
    end
  end
end
