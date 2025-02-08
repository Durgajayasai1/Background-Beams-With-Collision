import 'package:beams_collision/components/explosion_effect.dart';
import 'package:beams_collision/models/beam_model.dart';
import 'package:flutter/material.dart';

class CollisionEffect extends StatefulWidget {
  final BeamModel beamModel;
  final double containerHeight;
  const CollisionEffect(
      {required this.beamModel, required this.containerHeight, super.key});

  @override
  State<CollisionEffect> createState() => CollisionEffectState();
}

class CollisionEffectState extends State<CollisionEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isColliding = false;
  late Animation<double> _beamAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration:
          Duration(milliseconds: (widget.beamModel.duration * 1000).toInt()),
      vsync: this,
    );

    _beamAnimation = Tween<double>(
      begin: 0,
      end: widget.containerHeight + widget.beamModel.height * 2,
    ).animate(_controller);

    _controller.addListener(() {
      final beamTipPosition = _beamAnimation.value - widget.beamModel.height;

      if (beamTipPosition >= widget.containerHeight && !_isColliding) {
        setState(() {
          _isColliding = true;
        });

        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            setState(() {
              _isColliding = false;
            });
          }
        });
      }

      if (_controller.status == AnimationStatus.completed) {
        Future.delayed(
            Duration(
                milliseconds: (widget.beamModel.repeatDelay * 1000).toInt()),
            () {
          if (mounted) {
            _controller.reset();
            _controller.forward();
          }
        });
      }
    });

    Future.delayed(
        Duration(milliseconds: (widget.beamModel.delay * 1000).toInt()),
        () => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
          animation: _beamAnimation,
          builder: (context, child) {
            return Positioned(
              left: widget.beamModel.initialX,
              top: _beamAnimation.value - widget.beamModel.height,
              child: Container(
                width: 2,
                height: widget.beamModel.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.purple,
                      Colors.pink
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (_isColliding)
          ExplosionEffect(
            position: Offset(widget.beamModel.initialX, widget.containerHeight),
          ),
      ],
    );
  }
}
