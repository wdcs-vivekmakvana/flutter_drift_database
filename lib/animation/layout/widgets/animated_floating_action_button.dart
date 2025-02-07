import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/layout_animations.dart';

/// Animated Floating Action Button
class AnimatedFloatingActionButton extends StatefulWidget {
  /// Default constructor
  const AnimatedFloatingActionButton({
    required this.animation,
    super.key,
    this.elevation,
    this.onPressed,
    this.child,
  });

  /// Animation
  final Animation<double> animation;

  /// onPressed
  final VoidCallback? onPressed;

  /// Child widget
  final Widget? child;

  /// Elevation of the button (optional)
  final double? elevation;

  @override
  State<AnimatedFloatingActionButton> createState() => _AnimatedFloatingActionButton();
}

class _AnimatedFloatingActionButton extends State<AnimatedFloatingActionButton> {
  late final ColorScheme _colorScheme = Theme.of(context).colorScheme;
  late final Animation<double> _scaleAnimation = ScaleAnimation(parent: widget.animation);
  late final Animation<double> _shapeAnimation = ShapeAnimation(parent: widget.animation);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FloatingActionButton(
        elevation: widget.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(lerpDouble(30, 15, _shapeAnimation.value)!),
          ),
        ),
        backgroundColor: _colorScheme.tertiaryContainer,
        foregroundColor: _colorScheme.onTertiaryContainer,
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );
  }
}
