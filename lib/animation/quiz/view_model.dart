import 'package:flutter/cupertino.dart';
import 'package:flutter_local_data_base_drift/animation/quiz/models.dart';

/// Quiz view Model
class QuizViewModel extends ChangeNotifier {
  /// Default constructor
  QuizViewModel({required this.onGameOver}) {
    totalQuestions = _questionBank.remainingQuestions;
    getNextQuestion();
  }
  final QuestionBank _questionBank = QuestionBank();

  /// On Game Over Handler
  final VoidCallback onGameOver;

  /// Total Questions
  late final int totalQuestions;

  /// Current Question
  Question? currentQuestion;

  /// Answered Question Count
  int answeredQuestionCount = 0;

  /// Current Score
  int score = 0;

  /// Did Answer Question
  bool didAnswerQuestion = false;

  /// Has Next Question
  bool get hasNextQuestion => answeredQuestionCount < totalQuestions;

  /// Get Next Question
  void getNextQuestion() {
    if (_questionBank.hasNextQuestion) {
      currentQuestion = _questionBank.getRandomQuestion();
      answeredQuestionCount++;
    }

    didAnswerQuestion = false;

    notifyListeners();
  }

  /// Check Answer
  void checkAnswer(int selectedIndex) {
    if (!didAnswerQuestion && currentQuestion?.correctAnswer == selectedIndex) {
      score++;
    }

    didAnswerQuestion = true;

    if (!_questionBank.hasNextQuestion) {
      onGameOver();
    }

    notifyListeners();
  }
}
