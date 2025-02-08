import 'dart:math';

import 'package:beams_collision/models/explosion_particle.dart';
import 'package:beams_collision/painter/explosion_painter.dart';
import 'package:flutter/material.dart';

class ExplosionEffect extends StatefulWidget {
  final Offset position;
  const ExplosionEffect({required this.position, super.key});

  @override
  State<ExplosionEffect> createState() => ExplosionEffectState();
}

class ExplosionEffectState extends State<ExplosionEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ExplosionParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    final random = Random();
    for (int i = 0; i < 20; i++) {
      final angle = (i * pi * 2) / 20;
      final speed = random.nextDouble() * 40 + 60;
      final radius = random.nextDouble() * 4;

      _particles
          .add(ExplosionParticle(angle: angle, speed: speed, radius: radius));
    }

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - 100,
      top: widget.position.dy - 100,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: const Size(200, 200),
            painter: ExplosionPainter(
              position: const Offset(100, 100),
              progress: _controller.value,
              particles: _particles,
            ),
          );
        },
      ),
    );
  }
}
