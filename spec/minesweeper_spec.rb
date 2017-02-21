require 'spec_helper'

RSpec.describe Engine::Minesweeper do
  before(:each) do
    @minesweeper = Engine::Minesweeper.new(8, 8, 10)
  end

  after(:each) do
    @minesweeper = nil
  end

  describe '#board_state' do
    it 'should return a hash with board information' do
      expect(@minesweeper.board_state).to be_a Hash
      expect(@minesweeper.board_state[:undiscovered]).to be_a Array
    end
  end
end
