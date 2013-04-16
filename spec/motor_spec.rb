require_relative 'spec_helper'

describe Motor do
  before do
    @motor = Motor.new(forward: 11, enable: 12, backward: 13)
  end

  it "can be initialized with specified pins" do
    expect(@motor).to be_a Motor
  end

  it "creates a PiBlasterInterface for each pin" do
    expect(@motor.forward_pin).to be_a(PiBlasterInterface)
    expect(@motor.enable_pin).to be_a(PiBlasterInterface)
    expect(@motor.backward_pin).to be_a(PiBlasterInterface)
  end

  it "starts out going forward" do
    expect(@motor.direction).to eq(:forward)
  end

  it "can have its direction specified" do
    @motor.go_backward
    expect(@motor.direction).to eq(:backward)
    @motor.go_forward
    expect(@motor.direction).to eq(:forward)
  end

  it "starts out with all pins low" do
    expect(@motor.forward_pin.value).to eq(0)
    expect(@motor.enable_pin.value).to eq(0)
    expect(@motor.backward_pin.value).to eq(0)
  end

  it "sets forward pin high and backward pin low when going forward" do
    @motor.go_forward
    expect(@motor.forward_pin.value).to eq(1)
    expect(@motor.backward_pin.value).to eq(0)
  end

  it "sets forward pin low and backward pin high when going backward" do
    @motor.go_backward
    expect(@motor.forward_pin.value).to eq(0)
    expect(@motor.backward_pin.value).to eq(1)
  end

  it "sets enable pin value to its speed value" do
    @motor.speed = 1
    expect(@motor.speed).to eq(1)
    expect(@motor.enable_pin.value).to eq(1)
  end
end
