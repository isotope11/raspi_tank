require_relative 'spec_helper'

describe PiBlasterInterface do
  it "can be initialized with a specified pin" do
    blaster = PiBlasterInterface.new(11)
    expect(blaster).to be_a PiBlasterInterface
  end

  it "starts off with a value set to 0.0" do
    blaster = PiBlasterInterface.new(11)
    expect(blaster.value).to eq(0)
  end

  it "can have its value set from 0 to 1" do
    blaster = PiBlasterInterface.new(11)
    blaster.value = 1
    expect(blaster.value).to eq(1)
    blaster.value = 0
    expect(blaster.value).to eq(0)
    expect{ blaster.value = 2  }.to raise_error(OutOfRangeException)
    expect{ blaster.value = -1 }.to raise_error(OutOfRangeException)
  end

  it "outputs pi-blaster commands" do
    blaster = PiBlasterInterface.new(11)
    expect(blaster.pi_blaster_command).to eq("echo '11=0' > /dev/pi-blaster")
    blaster.value = 1
    expect(blaster.pi_blaster_command).to eq("echo '11=1' > /dev/pi-blaster")
  end
end
