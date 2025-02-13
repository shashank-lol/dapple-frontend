import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension CustomAnimations on Widget {
  /// Jumping Image Animation (Move from bottom + Scale)
  Animate jumpingAnimation() {
    return animate() // Start animation
        .moveY(begin: 300, end: 0, duration: 400.ms, curve: Curves.easeIn)
        .scale(
            begin: Offset(0.5, 0.5),
            end: Offset(1, 1),
            duration: 800.ms,
            curve: Curves.easeOut);
  }
}
