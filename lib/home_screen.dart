import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/quiz/quiz_screen.dart';
import 'package:flutter_local_data_base_drift/dm_screen.dart';
import 'package:flutter_local_data_base_drift/todo_screen.dart';

/// Home screen
class HomeScreen extends StatelessWidget {
  /// Default constructor
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => const TodoScreen(),
                  ),
                );
              },
              child: const Text('To do Demo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => const DmScreen(),
                  ),
                );
              },
              child: const Text('Dm Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => const QuizScreen(),
                  ),
                );
              },
              child: const Text('Animation Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
