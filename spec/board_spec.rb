require 'spec_helper'

RSpec.describe Engine::Board do
  before(:each) do
    @board = Engine::Board.new(8, 8)
  end

  after(:each) do
    @board = nil
  end

  describe '#add' do
    it 'should raise error, cell is not a Engine::Cell' do
      expect { @board.add(1) }.to raise_error TypeError
    end

    it 'should raise error, cell does not belong to the board' do
      cell = Engine::Cell.new(9, 9)
      expect { @board.add(cell) }.to raise_error ArgumentError
    end

    it 'should add a new cell with 8 neighbors' do
      cell = Engine::Cell.new(2, 2)
      add = @board.add cell

      expect(add).to be_an Engine::Cell
      expect(add).to eql(cell)

      expect(cell.neighborhood).not_to be_empty
      expect(cell.neighborhood.size).to eql(8)

      expect(cell.neighborhood[0]).to eql([1, 1])
      expect(cell.neighborhood[1]).to eql([2, 1])
      expect(cell.neighborhood[2]).to eql([3, 1])

      expect(cell.neighborhood[3]).to eql([1, 2])
      expect(cell.neighborhood[4]).to eql([3, 2])

      expect(cell.neighborhood[5]).to eql([1, 3])
      expect(cell.neighborhood[6]).to eql([2, 3])
      expect(cell.neighborhood[7]).to eql([3, 3])
    end

    it 'should add a new cell with 3 neighbors' do
      cell = Engine::Cell.new(1, 1)
      expect(cell.neighborhood).to be_empty

      add = @board.add cell

      expect(add).to be_a Engine::Cell
      expect(add).to eql(cell)

      expect(cell.neighborhood).not_to be_empty
      expect(cell.neighborhood.size).to eql(3)

      expect(cell.neighborhood[0]).to eql([2, 1])
      expect(cell.neighborhood[1]).to eql([1, 2])
      expect(cell.neighborhood[2]).to eql([2, 2])
    end
  end

  describe '#get' do
    it 'should raise TypeError' do
      expect { @board.get('a', 1) }.to raise_error TypeError
    end

    it 'should raise error, x < 0' do
      cell = Engine::Cell.new(1, 1)
      cell.is_discovered = true
      @board.add cell

      expect { @board.get(-1, 1) }.to raise_error ArgumentError
    end

    it 'should raise error, y > height' do
      cell = Engine::Cell.new(1, 1)
      cell.is_discovered = true
      @board.add cell

      expect { @board.get(1, 9) }.to raise_error ArgumentError
    end

    it 'should return nil because cell does not belong to the board' do
      cell = Engine::Cell.new(1, 1)
      cell.is_discovered = true
      @board.add cell

      expect(@board.get(2, 2)).to be_nil
    end

    it 'should get a cell' do
      cell = Engine::Cell.new(2, 2)
      cell.is_discovered = true
      @board.add cell

      other = @board.get 2, 2
      expect(cell).to eql(other)
      expect(cell.is_discovered).to eql(other.is_discovered)

      expect(other.neighborhood).not_to be_empty
      expect(other.neighborhood.size).to eql(8)

      expect(other.neighborhood[0]).to eql([1, 1])
      expect(other.neighborhood[1]).to eql([2, 1])
      expect(other.neighborhood[2]).to eql([3, 1])

      expect(other.neighborhood[3]).to eql([1, 2])
      expect(other.neighborhood[4]).to eql([3, 2])

      expect(other.neighborhood[5]).to eql([1, 3])
      expect(other.neighborhood[6]).to eql([2, 3])
      expect(other.neighborhood[7]).to eql([3, 3])
    end
  end

  describe '#each_neighbor' do
    it 'should raise TypeError' do
      expect { @board.each_neighbor 'cell' }.to raise_error TypeError
    end

    it 'should not raise error' do
      load_board 2
      cell = @board.get 1, 1

      expect { @board.each_neighbor cell }.not_to raise_error
    end

    it 'should return all 8 neighbor' do
      load_board 8
      cell = @board.get 2, 2

      count = 0
      @board.each_neighbor cell do |neighbor|
        expect(neighbor).to be_a Engine::Cell
        count += 1
      end

      expect(count).to eql(8)
    end

    def load_board(size)
      (1..size).each do |row|
        (1..size).each do |col|
          @board.add Engine::Cell.new(col, row)
        end
      end
    end
  end
end
