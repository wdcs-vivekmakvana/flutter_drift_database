import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/layout_animations.dart';

/// Bottom bar transition
class BottomBarTransition extends StatefulWidget {
  /// Default constructor
  const BottomBarTransition({required this.animation, required this.backgroundColor, required this.child, super.key});

  /// Animation
  final Animation<double> animation;

  /// Background color
  final Color backgroundColor;

  /// Child
  final Widget child;

  @override
  State<BottomBarTransition> createState() => _BottomBarTransition();
}

class _BottomBarTransition extends State<BottomBarTransition> {
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  ).animate(OffsetAnimation(parent: widget.animation));

  late final Animation<double> heightAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(SizeAnimation(parent: widget.animation));

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: heightAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
