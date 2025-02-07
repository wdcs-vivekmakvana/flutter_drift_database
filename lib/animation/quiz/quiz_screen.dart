import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/quiz/question_screen.dart';

/// Quiz Screen
class QuizScreen extends StatelessWidget {
  /// Default constructor
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '✏️',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'Flutter Quiz',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onPrimaryFixedVariant),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder<dynamic>(
                    pageBuilder: (_, __, ___) {
                      return const QuestionScreen();
                    },
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Text('New Game'),
            ),
          ],
        ),
      ),
    );
  }
}
