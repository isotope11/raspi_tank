module RaspiTank
  class PiBlasterInterface
    attr_reader :value

    def initialize(pin)
      @pin = pin
      @value = 0
    end

    def value=(val)
      validate_value(val)
      @value = val
      write_pin
    end

    def write_pin
      `#{pi_blaster_command}`
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
