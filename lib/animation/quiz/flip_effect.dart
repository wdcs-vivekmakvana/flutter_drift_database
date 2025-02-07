import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Card Flip effect
class CardFlipEffect extends StatefulWidget {
  /// Default constructor
  const CardFlipEffect({required this.child, required this.duration, required this.delayAmount, super.key});

  /// Child widget
  final Widget child;

  /// Duration of the animation
  final Duration duration;

  /// Delay amount
  final double delayAmount;

  @override
  State<CardFlipEffect> createState() => _CardFlipEffectState();
}

class _CardFlipEffectState extends State<CardFlipEffect> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  Widget? _previousChild;
  late final Animation<double> _animationWithDelay;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: widget.duration);
    animationController.addListener(() {
      if (animationController.value == 1) {
        animationController.reset();
      }
    });

    _animationWithDelay = TweenSequence<double>([
      if (widget.delayAmount > 0)
        TweenSequenceItem(
          tween: ConstantTween<double>(0),
          weight: widget.delayAmount,
        ),
      TweenSequenceItem(
        tween: Tween(begin: 0, end: 1),
        weight: 1,
      ),
    ]).animate(animationController);
  }

  @override
  void didUpdateWidget(covariant CardFlipEffect oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.child.key != oldWidget.child.key) {
      _handleChildChanged(widget.child, oldWidget.child);
    }
  }

  void _handleChildChanged(Widget newChild, Widget previousChild) {
    _previousChild = previousChild;
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationWithDelay,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateX(_animationWithDelay.value * math.pi),
          child: animationController.isAnimating
              ? _animationWithDelay.value < 0.5
                  ? _previousChild
                  : Transform.flip(flipY: true, child: child)
              : child,
        );
      },
      child: widget.child,
    );
  }
}
