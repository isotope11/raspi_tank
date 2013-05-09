module RaspiTank
  class Motor
    def initialize(options={})
      @pin_number = options.fetch(:pin){  raise "pin must be specified"  }
    end

    def pin
      @pin ||= PiBlasterInterface.new(@pin_number)
    end

    def go_backward
      self.direction = :backward
      pin.value = minimum_speed
    end

    def go_forward
      self.direction = :forward
      pin.value = maximum_speed
    end

    def speed=(new)
      validate_speed(new)
      @speed = new
      enable_pin.value = new
    end

    def direction
      current_value > idle ? :forward : :backward
    end

    def current_value
      pin.value
    end

    def stop
      self.speed = 0
    end

    protected
    attr_writer :direction

    def validate_speed(new)
      return true if valid_speeds.cover?(new)
      raise OutOfRangeException, "Invalid speed: #{new}"
    end

    def valid_speeds
      (minimum_speed..maximum_speed)
    end

    # in microseconds
    def minimum_speed
      1_000 / max_pulse_width
    end

    # in microseconds
    def maximum_speed
      2_000 / max_pulse_width
    end

    # in microseconds
    def idle
      1_500 / max_pulse_width
    end

    def max_pulse_width
      10_000
    end
  end
end
