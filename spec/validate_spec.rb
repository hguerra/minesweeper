require 'spec_helper'

RSpec.describe Engine::Validate do
  context 'when trying to create a new instance' do
    it 'should raise error' do
      expect { Engine::Validate.new }.to raise_error NoMethodError
    end
  end

  describe '#type' do
    it 'should raise error' do
      expect { Engine::Validate.type('name', String, 1) }.to raise_error TypeError
    end

    it 'should not raise error' do
      expect { Engine::Validate.type('name', String, 'arg') }.not_to raise_error
    end
  end

  describe '#positive_argument' do
    it 'should raise error' do
      expect { Engine::Validate.positive_argument('x', -1) }.to raise_error ArgumentError
    end

    it 'should not raise error' do
      expect { Engine::Validate.positive_argument('x', 0) }.not_to raise_error
    end
  end
end
