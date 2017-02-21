require 'spec_helper'

RSpec.describe Engine::Cell do
  before(:each) do
    @cell = Engine::Cell.new(0, 1)
  end

  describe '#x' do
    context 'change cell position' do
      it 'should not has a setter for x' do
        expect { @cell.x = 10 }.to raise_error NoMethodError
      end
    end

    context 'get x' do
      it 'should return 0 when access cell.x' do
        expect(@cell.x).to eql(0)
      end
    end
  end

  describe '#y' do
    context 'change cell position' do
      it 'should not has a setter for y' do
        expect { @cell.y = 10 }.to raise_error NoMethodError
      end
    end

    context 'get y' do
      it 'should return 1 when access cell.y' do
        expect(@cell.y).to eql(1)
      end
    end
  end

  describe '#neighborhood' do
    it 'should an array' do
      expect(@cell.neighborhood).to be_an Array
    end

    it 'should not has a setter for neighborhood' do
      expect { @cell.neighborhood = 'abc' }.to raise_error NoMethodError
    end

    it 'should return an empty array' do
      expect(@cell.neighborhood).to be_empty
    end

    it 'should return an array with rows and cols' do
      @cell.neighborhood << [0, 0]
      @cell.neighborhood << [0, 1]
      @cell.neighborhood << [0, 2]

      @cell.neighborhood << [1, 0]
      @cell.neighborhood << [1, 2]

      @cell.neighborhood << [2, 0]
      @cell.neighborhood << [2, 1]
      @cell.neighborhood << [2, 2]

      expect(@cell.neighborhood).not_to be_empty
      expect(@cell.neighborhood.size).to eql(8)

      expect(@cell.neighborhood[0]).to eql([0, 0])
      expect(@cell.neighborhood[1]).to eql([0, 1])
      expect(@cell.neighborhood[2]).to eql([0, 2])

      expect(@cell.neighborhood[3]).to eql([1, 0])
      expect(@cell.neighborhood[4]).to eql([1, 2])

      expect(@cell.neighborhood[5]).to eql([2, 0])
      expect(@cell.neighborhood[6]).to eql([2, 1])
      expect(@cell.neighborhood[7]).to eql([2, 2])
    end
  end

  describe '#has_mine' do
    it 'should return false when access cell.has_mine' do
      expect(@cell.has_mine).to be_falsey
    end

    it 'should return true after set cell.has_mine' do
      @cell.has_mine = true
      expect(@cell.has_mine).to be_truthy
    end
  end

  describe '#is_discovered' do
    it 'should return false when access cell.is_discovered' do
      expect(@cell.is_discovered).to be_falsey
    end

    it 'should return true after set cell.is_discovered' do
      @cell.is_discovered = true
      expect(@cell.is_discovered).to be_truthy
    end
  end

  describe '#has_flag' do
    it 'should return false when access cell.has_flag' do
      expect(@cell.has_flag).to be_falsey
    end

    it 'should return true after set cell.has_flag' do
      @cell.has_flag = true
      expect(@cell.has_flag).to be_truthy
    end
  end
end
