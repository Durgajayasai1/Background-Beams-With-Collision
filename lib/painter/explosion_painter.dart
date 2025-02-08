import 'package:beams_collision/models/explosion_particle.dart';
import 'package:flutter/material.dart';

class ExplosionPainter extends CustomPainter {
  final Offset position;
  final double progress;
  final List<ExplosionParticle> particles;

  ExplosionPainter({
    required this.position,
    required this.progress,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.pinkAccent;

    for (var particle in particles) {
      particle.update(progress);
      canvas.drawCircle(position + particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
