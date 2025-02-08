import 'dart:math';
import 'package:beams_collision/components/collision_effect.dart';
import 'package:beams_collision/models/beam_model.dart';
import 'package:flutter/material.dart';

class BackgroundBeamsWithCollision extends StatefulWidget {
  final Widget? child;

  const BackgroundBeamsWithCollision({super.key, this.child});

  @override
  State<BackgroundBeamsWithCollision> createState() =>
      _BackgroundBeamsWithCollisionState();
}

class _BackgroundBeamsWithCollisionState
    extends State<BackgroundBeamsWithCollision> {
  late List<BeamModel> beams;
  late double containerWidth;
  late double containerHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    containerWidth = MediaQuery.of(context).size.width;
    containerHeight = MediaQuery.of(context).size.height * 0.85;
    _initializeBeams();
  }

  void _initializeBeams() {
    final random = Random();
    beams = List.generate(
      7,
      (index) => BeamModel(
        initialX: random.nextDouble() * containerWidth,
        duration: random.nextDouble() * 3 + 1,
        repeatDelay: random.nextDouble() * 3,
        delay: random.nextDouble() * 4,
        height: [24.0, 48.0, 80.0][random.nextInt(3)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      width: containerWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...beams.map((beam) => CollisionEffect(
                key: ValueKey('${beam.initialX}-beam'),
                containerHeight: containerHeight,
                beamModel: beam,
              )),
          if (widget.child != null) Center(child: widget.child!),
        ],
      ),
    );
  }
}
