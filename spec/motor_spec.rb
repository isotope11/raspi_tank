require 'rspec'
require 'rspec/autorun'

module RaspiTank
  class OutOfRangeException < StandardError; end

  class Motor
    def initialize(options={})
      @forward  = options.fetch(:forward){  raise "forward must be specified"  }
      @backward = options.fetch(:backward){ raise "backward must be specified" }
      @enable   = options.fetch(:enable){   raise "enable must be specified"   }
    end
  end

  class PiBlasterInterface
    attr_reader :value

    def initialize(pin)
      @pin = pin
      @value = 0
    end

    def value=(val)
      validate_value(val)
      @value = val
    end

    def pi_blaster_command
      "echo '#{pin}=#{value}' > /dev/pi-blaster"
    end

    protected
    attr_reader :pin

    def validate_value(val)
      return true if valid_values.cover?(val)
      raise OutOfRangeException, "Invalid value: #{val}"
    end

    def valid_values
      (0..1)
    end
  end
end

include RaspiTank

describe Motor do
  it "can be initialized with specified pins" do
    motor = Motor.new(forward: 11, enable: 12, backward: 13)
    expect(motor).to be_a Motor
  end
end

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
