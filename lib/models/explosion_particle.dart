import 'dart:math';
import 'package:flutter/material.dart';

class ExplosionParticle {
  final double angle;
  final double speed;
  final double radius;
  late Offset position;

  ExplosionParticle({
    required this.angle,
    required this.speed,
    required this.radius,
  }) {
    position = Offset(0, 0); // Starts at explosion center
  }

  void update(double progress) {
    position = Offset(
      cos(angle) * speed * progress,
      sin(angle) * speed * progress,
    );
  }
}
