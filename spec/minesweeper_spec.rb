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
        @minesweeper.play(2, 1)
        expect(@minesweeper.play(2, 1)).to be_falsey
      end
    end

    context 'when user clicked on a cell that was discovered because their neighbors has no mines' do
      it 'should return false' do
        @minesweeper.play(1, 4)
        expect(@minesweeper.play(2, 4)).to be_falsey
      end
    end

    context 'when user clicked in all discovered cells with no mines' do
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
        expect(@minesweeper.play(3, 4)).to be_truthy
      end
    end
  end
end
