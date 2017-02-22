require 'spec_helper'

RSpec.describe Engine do
  it 'has a version number' do
    expect(Engine::VERSION).not_to be nil
  end
end
