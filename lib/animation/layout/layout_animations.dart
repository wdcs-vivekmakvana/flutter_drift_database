import 'package:flutter/animation.dart';

/// Bar Animation
class BarAnimation extends ReverseAnimation {
  /// Default constructor
  BarAnimation({required AnimationController parent})
      : super(
          CurvedAnimation(
            parent: parent,
            curve: const Interval(0, 1 / 5),
            reverseCurve: const Interval(1 / 5, 4 / 5),
          ),
        );
}

/// Offset Animation
class OffsetAnimation extends CurvedAnimation {
  /// Default constructor
  OffsetAnimation({required super.parent})
      : super(
          curve: const Interval(
            2 / 5,
            3 / 5,
            curve: Curves.easeInOutCubicEmphasized,
          ),
          reverseCurve: Interval(
            4 / 5,
            1,
            curve: Curves.easeInOutCubicEmphasized.flipped,
          ),
        );
}

/// Rail animation
class RailAnimation extends CurvedAnimation {
  /// Default constructor
  RailAnimation({required super.parent})
      : super(
          curve: const Interval(0 / 5, 4 / 5),
          reverseCurve: const Interval(3 / 5, 1),
        );
}

/// Rail fab animation
class RailFabAnimation extends CurvedAnimation {
  /// Default constructor
  RailFabAnimation({required super.parent})
      : super(
          curve: const Interval(3 / 5, 1),
        );
}

/// Scale animation
class ScaleAnimation extends CurvedAnimation {
  ///
  ScaleAnimation({required super.parent})
      : super(
          curve: const Interval(
            3 / 5,
            4 / 5,
            curve: Curves.easeInOutCubicEmphasized,
          ),
          reverseCurve: Interval(
            3 / 5,
            1,
            curve: Curves.easeInOutCubicEmphasized.flipped,
          ),
        );
}

/// Shape animation
class ShapeAnimation extends CurvedAnimation {
  /// Default constructor
  ShapeAnimation({required super.parent})
      : super(
          curve: const Interval(
            2 / 5,
            3 / 5,
            curve: Curves.easeInOutCubicEmphasized,
          ),
        );
}

/// Size Animation
class SizeAnimation extends CurvedAnimation {
  /// Default constructor
  SizeAnimation({required super.parent})
      : super(
          curve: const Interval(
            0 / 5,
            3 / 5,
            curve: Curves.easeInOutCubicEmphasized,
          ),
          reverseCurve: Interval(
            2 / 5,
            1,
            curve: Curves.easeInOutCubicEmphasized.flipped,
          ),
        );
}
