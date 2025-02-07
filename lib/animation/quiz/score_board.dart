import 'package:flutter/material.dart';

/// Score Board
class ScoreBoard extends StatelessWidget {
  /// Default constructor
  const ScoreBoard({required this.score, required this.totalQuestions, super.key});

  /// User gain score
  final int score;

  /// Total Questions
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < totalQuestions; i++) AnimatedStar(isActive: score > i),
        ],
      ),
    );
  }
}

/// Animated Star
class AnimatedStar extends StatelessWidget {
  /// Default Constructor
  const AnimatedStar({required this.isActive, super.key});

  /// Star is active or not
  final bool isActive;

  /// Animation duration

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 1000);
    final deactivatedColor = Colors.grey.shade400;
    final activatedColor = Colors.yellow.shade700;
    const Curve curve = Curves.elasticOut;
    return AnimatedScale(
      scale: isActive ? 1.0 : 0.5,
      duration: duration,
      curve: curve,
      child: TweenAnimationBuilder(
        duration: duration,
        curve: curve,
        tween: ColorTween(
          begin: deactivatedColor,
          end: isActive ? activatedColor : deactivatedColor,
        ),
        builder: (context, value, _) {
          return Icon(
            Icons.star,
            size: 50,
            color: value,
          );
        },
      ),
    );
  }
}
