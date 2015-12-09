require 'spec_helper'

describe Robot do
  it 'has a version number' do
    expect(Robot::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(false)
  end
end
