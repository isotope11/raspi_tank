require_relative '../lib/raspi_tank'

include RaspiTank

left = Motor.new(pin: 0)
right = Motor.new(pin: 1)
left.go_forward
right.go_forward
sleep 2
right.go_backward
sleep 2
left.go_backward
sleep 2
left.stop
right.stop
