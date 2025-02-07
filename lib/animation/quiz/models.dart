import 'dart:math' as math;

/// Question Model
class Question {
  /// Default Constructor
  Question(this.question, this.possibleAnswers, this.correctAnswer);

  /// Question
  final String question;

  /// Possible answers for the question
  final List<String> possibleAnswers;

  /// Correct answer index
  final int correctAnswer;
}

/// Question Bank
class QuestionBank {
  /// Question List
  final List<Question> _questions = _createQuestions();

  /// Has Next Question
  bool get hasNextQuestion => _questions.isNotEmpty;

  /// Remaining Question
  int get remainingQuestions => _questions.length;

  /// Get Random Question
  Question? getRandomQuestion() {
    if (_questions.isEmpty) {
      return null;
    }

    final i = math.Random().nextInt(_questions.length);
    final question = _questions[i];

    _questions.removeAt(i);
    return question;
  }
}

List<Question> _createQuestions() {
  return [
    Question(
      'What class used to create custom explicit animations in Flutter?',
      [
        'AnimationController',
        'AnimatedWidget',
        'AnimatedBuilder',
        'Tween',
      ],
      0,
    ),
    Question(
      'Which widget is used to rebuild its child whenever an animation changes?',
      [
        'AnimatedContainer',
        'AnimatedBuilder',
        'AnimatedSwitcher',
        'AnimatedOpacity',
      ],
      1,
    ),
    Question(
      'What class is used to define the start and end values for an animation?',
      [
        'Tween',
        'Curve',
        'AnimationController',
        'AnimatedWidget',
      ],
      0,
    ),
    Question(
      'How are you?',
      [
        'Mind your own business',
        'Fine',
        'All Well, what about you?',
        'Nothing',
      ],
      0,
    ),
  ];
}
