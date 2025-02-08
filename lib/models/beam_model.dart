class BeamModel {
  final double initialX;
  final double duration;
  final double repeatDelay;
  final double delay;
  final double height;

  BeamModel({
    required this.initialX,
    required this.duration,
    required this.repeatDelay,
    this.delay = 0,
    this.height = 56,
  });
}
