require_relative '../lib/raspi_tank'

include RaspiTank

m = Motor.new(pin: 0)
m.go_forward
sleep 5
m.go_backward
