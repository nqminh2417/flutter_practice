// Import the sin and pi functions from the math library with the name "math"
import 'dart:math' as math show sin, pi;

// Import the Animation class from the flutter/animation library
import 'package:flutter/animation.dart';

// Define a DelayTween class that extends the Tween class for double values
class DelayTween extends Tween<double> {
  // The constructor for the DelayTween class
  DelayTween({double? begin, double? end, required this.delay})
      : super(begin: begin, end: end);

  // The delay value for the animation
  final double delay;

  // Override the lerp method to adjust the animation's progress based on the delay value
  @override
  double lerp(double t) {
    // Use the sin function from the math library to calculate a sine wave based on the current time and delay
    // Add 1 to the result to make sure it's always positive, then divide by 2 to get a value between 0 and 1
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  // Override the evaluate method to call the lerp method with the animation's current value
  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}

// Define a DelayTweenOffset class that extends the Tween class for Offset values
class DelayTweenOffset extends Tween<Offset> {
  // The constructor for the DelayTweenOffset class
  DelayTweenOffset({Offset? begin, Offset? end, required this.delay})
      : super(begin: begin, end: end);

  // The delay value for the animation
  final double delay;

  // Override the lerp method to adjust the animation's progress based on the delay value
  @override
  Offset lerp(double t) {
    // Use the sin function from the math library to calculate a sine wave based on the current time and delay
    // Add 1 to the result to make sure it's always positive, then divide by 2 to get a value between 0 and 1
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  // Override the evaluate method to call the lerp method with the animation's current value
  @override
  Offset evaluate(Animation<double> animation) => lerp(animation.value);
}
