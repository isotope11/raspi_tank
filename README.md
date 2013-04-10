# Raspi Tank

This is a project meant to run on a raspberry pi and control a remote control tank.

It will also include a mode that allows it to export the main object over drb for network-control.

## API

So the api should look like the following:

```ruby
# Initialize the motor driver objects
left_motor = RaspiTank::Motor.new(forward: 11, enable: 12, backward: 13)
right_motor = RaspiTank::Motor.new(forward: 16, enable: 17, backward: 18)

# Initialize the tank
tank = RaspiTank.new(left_motor: left_motor, right_motor: right_motor)
```

At this point, you have a `tank` object that you can manipulate (and two motor objects that you shouldn't manipulate directly).  Let's explore it:

```ruby
tank.right_speed # => 0
tank.left_speed # => 0
```

So for now, it's not actually outputting anything to the motor pins.  To trigger that, you would call go (this is intended to be run in a loop)

```ruby
tank.go
```

That will check the current tank state, and change the GPIO pins to match that state.

For reference w/r/t how the motor objects work:

```ruby
# Motors are set to go forward by default
left_motor.direction # => :forward
# The motor hasn't been engaged, so no pins have been set high
# They are set low on initialization
left_motor.go
# Now the `forward` pin is high, the `backward` pin is low, and the `enable` pin is high.
left_motor.go_backward
# Now the `forward` pin is low, the `backward` pin is high, and the `enable` pin is high.
left_motor.stop
# Now nothing changed except the `enable` pin is low.
left_motor.speed = 0.5
# Now the `enable` pin will be high half the time
```

## References

The plan presently is to use [ServoBlaster](https://github.com/richardghirst/PiBits/tree/master/ServoBlaster) to manage the motors.

Per JD, here are changes we would want to make to servod.c:


[15:05] <          jd> | so this is what I thought it was by default and it looks like that you cannot drive a regular motor from this without changing the defaults.... but that you can do, here is what I would do:
[15:05] <          jd> | Servo cycle time:    1000us
[15:05] <          jd> | this would set the frequency of the switching to be 1000 times per second (or every 1000 microseconds)
[15:07] <          jd> | change this: Maximum width value:   249 (2490us)
[15:07] <          jd> | to this: Maximum width value:   100
[15:49] <          jd> | when we leave the pulse width units at "10" us, then we can have a maximum of 100 increments of 10 microseconds, effectively allowing for a maximum of 1000 microseconds HIGH between each pulse (which gets us 100%)
