require 'spec_helper'

RSpec.describe Engine::Cell do
  before(:each) do
    @cell = Engine::Cell.new(0, 1)
  end

  context 'change cell position' do
    it 'should not has a setter for x' do
      expect { @cell.x = 10 }.to raise_error NoMethodError
    end

    it 'should not has a setter for y' do
      expect { @cell.y = 10 }.to raise_error NoMethodError
    end
  end

  context 'access attributes' do
    it 'should return 0 when access cell.x' do
      expect(@cell.x).to eql(0)
    end

    it 'should return 1 when access cell.y' do
      expect(@cell.y).to eql(1)
    end

    it 'should return false when access cell.has_mine' do
      expect(@cell.has_mine).to be_falsey
    end

    it 'should return false when access cell.is_discovered' do
      expect(@cell.is_discovered).to be_falsey
    end

    it 'should return false when access cell.has_flag' do
      expect(@cell.has_flag).to be_falsey
    end

    it 'should return true after set cell.has_mine' do
      @cell.has_mine = true
      expect(@cell.has_mine).to be_truthy
    end

    it 'should returntrue after set cell.is_discovered' do
      @cell.is_discovered = true
      expect(@cell.is_discovered).to be_truthy
    end

    it 'should return true after set cell.has_flag' do
      @cell.has_flag = true
      expect(@cell.has_flag).to be_truthy
    end
  end
end
