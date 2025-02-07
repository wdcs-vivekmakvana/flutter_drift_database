import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/quiz/flip_effect.dart';
import 'package:flutter_local_data_base_drift/animation/quiz/score_board.dart';
import 'package:flutter_local_data_base_drift/animation/quiz/view_model.dart';

/// Question Screen
class QuestionScreen extends StatefulWidget {
  /// Default constructor
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late final QuizViewModel viewModel = QuizViewModel(onGameOver: _handleGameOver);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: viewModel.hasNextQuestion && viewModel.didAnswerQuestion
                    ? () {
                        viewModel.getNextQuestion();
                      }
                    : null,
                child: const Text('Next'),
              ),
            ],
          ),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    QuestionCard(question: viewModel.currentQuestion?.question),
                    const Spacer(),
                    AnswerCards(
                      onTapped: (index) {
                        viewModel.checkAnswer(index);
                      },
                      answers: viewModel.currentQuestion?.possibleAnswers ?? [],
                      correctAnswer: viewModel.didAnswerQuestion ? viewModel.currentQuestion?.correctAnswer : null,
                    ),
                    StatusBar(viewModel: viewModel),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleGameOver() {
    showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: Text('Score: ${viewModel.score}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

/// Question Card View
class QuestionCard extends StatelessWidget {
  /// Default constructor
  const QuestionCard({
    required this.question,
    super.key,
  });

  /// Question
  final String? question;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        final curveAnimation = CurveTween(curve: Curves.easeInCubic).animate(animation);
        final offsetAnimation = Tween<Offset>(begin: const Offset(-0.1, 0), end: Offset.zero).animate(curveAnimation);
        final fadeInAnimation = curveAnimation;
        return FadeTransition(
          opacity: fadeInAnimation,
          child: SlideTransition(position: offsetAnimation, child: child),
        );
      },
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      child: Card(
        key: ValueKey(question),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            question ?? '',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ),
    );
  }
}

/// Answer Cards
class AnswerCards extends StatelessWidget {
  /// Default constructor
  const AnswerCards({
    required this.answers,
    required this.onTapped,
    required this.correctAnswer,
    super.key,
  });

  /// Answer List
  final List<String> answers;

  /// Tap Event Handler
  final ValueChanged<int> onTapped;

  /// Is Correct Answer
  final int? correctAnswer;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 4 / 2,
      children: List.generate(answers.length, (index) {
        var color = Theme.of(context).colorScheme.primaryContainer;
        if (correctAnswer == index) {
          color = Theme.of(context).colorScheme.tertiaryContainer;
        }
        return CardFlipEffect(
          duration: const Duration(milliseconds: 300),
          delayAmount: index / 2,
          child: Card.filled(
            key: ValueKey(answers[index]),
            color: color,
            elevation: 2,
            margin: const EdgeInsets.all(8),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () => onTapped(index),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    answers.length > index ? answers[index] : '',
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// Status Bar
class StatusBar extends StatelessWidget {
  /// Default constructor
  const StatusBar({required this.viewModel, super.key});

  /// Quiz View Model
  final QuizViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ScoreBoard(
          score: viewModel.score,
          totalQuestions: viewModel.totalQuestions,
        ),
      ),
    );
  }
}
