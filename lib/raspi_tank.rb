module RaspiTank
  class OutOfRangeException < StandardError; end
end

require_relative 'raspi_tank/motor'
require_relative 'raspi_tank/pi_blaster_interface'
