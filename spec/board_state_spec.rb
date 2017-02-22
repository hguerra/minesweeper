require 'spec_helper'

RSpec.describe Engine::BoardState do
  before(:each) do
    @board = create_board
    @board_state = Engine::BoardState.new(@board)
  end

  after(:each) do
    @board = nil
    @board_state = nil
  end

  describe 'Wrong type of argument' do
    it 'should railse error' do
      expect { Engine::BoardState.new(1) }.to raise_error TypeError
    end
  end

  describe '#get' do
    it 'should return a array' do
      expect(@board_state.get).to be_an Array
    end

    it 'get state of cells' do
      rows = @board_state.get

      col = rows[0]
      expect(col[0]).to eql(:discovered_mine)
      expect(col[1]).to eql(1)
      expect(col[2]).to eql(:discovered)

      col = rows[1]
      expect(col[0]).to eql(2)
      expect(col[1]).to eql(:undiscovered)
      expect(col[2]).to eql(:undiscovered)

      col = rows[2]
      expect(col[0]).to eql(:undiscovered)
      expect(col[1]).to eql(:undiscovered)
      expect(col[2]).to eql(:undiscovered_flag)
    end

    it 'get state of cells with xray' do
      @board_state = Engine::BoardState.new(@board, {xray: true})
      rows = @board_state.get

      col = rows[0]
      expect(col[0]).to eql(:discovered_mine)
      expect(col[1]).to eql(1)
      expect(col[2]).to eql(:discovered)

      col = rows[1]
      expect(col[0]).to eql(2)
      expect(col[1]).to eql(:undiscovered)
      expect(col[2]).to eql(:undiscovered)

      col = rows[2]
      expect(col[0]).to eql(:undiscovered_mine)
      expect(col[1]).to eql(:undiscovered)
      expect(col[2]).to eql(:undiscovered_mine)
    end
  end

  def create_board
    board = Engine::Board.new(3, 3)

    discovered_mine = Engine::Cell.new(1, 1)
    discovered_mine.is_discovered = true
    discovered_mine.has_mine = true
    board.add discovered_mine

    discovered_neighbor_mine = Engine::Cell.new(2, 1)
    discovered_neighbor_mine.is_discovered = true
    discovered_neighbor_mine.neighbor_mine = 1
    board.add discovered_neighbor_mine

    discovered = Engine::Cell.new(3, 1)
    discovered.is_discovered = true
    board.add discovered

    discovered_neighbor_mine = Engine::Cell.new(1, 2)
    discovered_neighbor_mine.is_discovered = true
    discovered_neighbor_mine.neighbor_mine = 2
    board.add discovered_neighbor_mine

    board.add Engine::Cell.new(2, 2)
    board.add Engine::Cell.new(3, 2)

    undiscovered_mine = Engine::Cell.new(1, 3)
    undiscovered_mine.has_mine = true
    board.add undiscovered_mine

    board.add Engine::Cell.new(2, 3)

    undiscovered_flag = Engine::Cell.new(3, 3)
    undiscovered_flag.has_mine = true
    undiscovered_flag.has_flag = true
    board.add undiscovered_flag

    board
  end
end
