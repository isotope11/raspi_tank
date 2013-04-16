require 'rspec'
require 'rspec/autorun'

module RaspiTank
  class Motor
    def initialize(options={})
      @forward  = options.fetch(:forward){  raise "forward must be specified"  }
      @backward = options.fetch(:backward){ raise "backward must be specified" }
      @enable   = options.fetch(:enable){   raise "enable must be specified"   }
    end
  end
end

include RaspiTank

describe Motor do
  it "can be initialized with specified pins" do
    motor = Motor.new(forward: 11, enable: 12, backward: 13)
    motor.should be_a Motor
  end
end
