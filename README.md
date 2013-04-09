# Raspi Car

This is a project meant to run on a raspberry pi and control a remote control car.

It will also include a mode that allows it to export the main object over drb for network-control.

## API

So the api should look like the following:

```ruby
# Initialize the motor driver objects
left_motor = RaspiCar::Motor.new(forward: 11, enable: 12, backward: 13)
right_motor = RaspiCar::Motor.new(forward: 16, enable: 17, backward: 18)

# Initialize the car
car = RaspiCar.new(left_motor: left_motor, right_motor: right_motor)
```

At this point, you have a `car` object that you can manipulate (and two motor objects that you shouldn't manipulate directly).  Let's explore it:

```ruby
car.speed # => 0
car.heading # => 0
```

So for now, it's not actually outputting anything to the motor pins.  To trigger that, you would call go (this is intended to be run in a loop)

```ruby
car.go
```

That will check the current car state, and change the GPIO pins to match that state.

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
```
