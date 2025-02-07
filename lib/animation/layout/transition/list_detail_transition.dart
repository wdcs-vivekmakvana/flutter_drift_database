import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/layout_animations.dart';

/// List detail transition
class ListDetailTransition extends StatefulWidget {
  /// Default constructor
  const ListDetailTransition({
    required this.animation,
    required this.one,
    required this.two,
    super.key,
  });

  /// The animation to use for the transition
  final Animation<double> animation;

  /// The first child of the transition
  final Widget one;

  /// The second child of the transition
  final Widget two;

  @override
  State<ListDetailTransition> createState() => _ListDetailTransitionState();
}

class _ListDetailTransitionState extends State<ListDetailTransition> {
  Animation<double> widthAnimation = const AlwaysStoppedAnimation(0);
  late final Animation<double> sizeAnimation = SizeAnimation(parent: widget.animation);
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).animate(OffsetAnimation(parent: sizeAnimation));
  double currentFlexFactor = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final width = MediaQuery.of(context).size.width;
    final nextFlexFactor = switch (width) {
      >= 800 && < 1200 => lerpDouble(1000, 2000, (width - 800) / 400)!,
      >= 1200 && < 1600 => lerpDouble(2000, 3000, (width - 1200) / 400)!,
      >= 1600 => 3000,
      _ => 1000,
    };

    if (nextFlexFactor == currentFlexFactor) {
      return;
    }

    if (currentFlexFactor == 0) {
      widthAnimation = Tween<double>(begin: 0, end: nextFlexFactor.toDouble()).animate(sizeAnimation);
    } else {
      final sequence = TweenSequence<double>([
        if (sizeAnimation.value > 0) ...[
          TweenSequenceItem(
            tween: Tween(begin: 0, end: widthAnimation.value),
            weight: sizeAnimation.value,
          ),
        ],
        if (sizeAnimation.value < 1) ...[
          TweenSequenceItem(
            tween: Tween(begin: widthAnimation.value, end: nextFlexFactor.toDouble()),
            weight: 1 - sizeAnimation.value,
          ),
        ],
      ]);

      widthAnimation = sequence.animate(sizeAnimation);
    }

    currentFlexFactor = nextFlexFactor.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return widthAnimation.value.toInt() == 0
        ? widget.one
        : Row(
            children: [
              Flexible(
                flex: 1000,
                child: widget.one,
              ),
              Flexible(
                flex: widthAnimation.value.toInt(),
                child: FractionalTranslation(
                  translation: offsetAnimation.value,
                  child: widget.two,
                ),
              ),
            ],
          );
  }
}
