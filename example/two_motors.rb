require_relative '../lib/raspi_tank'

include RaspiTank

@left = Motor.new(pin: 0)
@right = Motor.new(pin: 1)

$all_the_way = 1.1

def turn_right(angle)
  @left.go_forward
  @right.go_backward
  sleep (angle/360) * $all_the_way
end

def turn_around
  puts "Turning around"
  turn_right(360)
end

def go_forward_for(secs)
  puts "Going forward for #{secs} seconds"
  @left.go_forward
  @right.go_forward
  sleep secs
end

def stop
  puts "Stopping"
  @left.stop
  @right.stop
end

trap("SIGINT"){ stop; exit }

go_forward_for 1
#turn_around
260.times do
  go_forward_for 0.05
  turn_right(40)
end
stop






#go_forward_for 20
#turn_around
#go_forward_for 20
#stop
