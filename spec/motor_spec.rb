require_relative 'spec_helper'

describe Motor do
  it "can be initialized with specified pins" do
    motor = Motor.new(forward: 11, enable: 12, backward: 13)
    expect(motor).to be_a Motor
  end
end
