module RaspiTank
  class Motor
    attr_reader :direction, :speed

    def initialize(options={})
      @forward   = options.fetch(:forward){  raise "forward must be specified"  }
      @backward  = options.fetch(:backward){ raise "backward must be specified" }
      @enable    = options.fetch(:enable){   raise "enable must be specified"   }
      @direction = :forward
      @speed     = 0
    end

    def forward_pin
      @forward_pin ||= PiBlasterInterface.new(@forward)
    end

    def backward_pin
      @backward_pin ||= PiBlasterInterface.new(@backward)
    end

    def enable_pin
      @enable_pin ||= PiBlasterInterface.new(@enable)
    end

    def go_backward
      self.direction = :backward
      forward_pin.value = 0
      backward_pin.value = 1
    end

    def go_forward
      self.direction = :forward
      forward_pin.value = 1
      backward_pin.value = 0
    end

    def speed=(new)
      validate_speed(new)
      @speed = new
      enable_pin.value = new
    end

    protected
    attr_writer :direction

    def validate_speed(new)
      return true if valid_speeds.cover?(new)
      raise OutOfRangeException, "Invalid speed: #{new}"
    end

    def valid_speeds
      (0..1)
    end
  end
end
