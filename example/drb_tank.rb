require 'drb/drb'
require_relative '../lib/raspi_tank'

# The URI for the server to connect to
URI="druby://0.0.0.0:8787"

class Tank
  include RaspiTank

  def initialize
    @left = Motor.new(pin: 0)
    @right = Motor.new(pin: 1)
  end

  # Takes -1..1 and maps
  def set(left_value, right_value)
    @left.analog_speed = left_value
    @right.analog_speed = right_value
  end
end

# The object that handles requests on the server
FRONT_OBJECT=Tank.new

$SAFE = 1   # disable eval() and friends

DRb.start_service(URI, FRONT_OBJECT)
# Wait for the drb server thread to finish before exiting.
DRb.thread.join

