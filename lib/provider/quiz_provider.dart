import 'dart:async';
import 'package:flutter/material.dart';
import 'package:veggiez/data/dummy.dart';

class QuizProvider extends ChangeNotifier {
  int currentQuestionIndex = 0;
  int? selectedOption;
  bool answered = false;
  int secondsLeft = 10;
  int score = 0;

  Timer? _timer;
  bool _isDisposed = false;

  void startTimer(VoidCallback onTimeout) {
    stopTimer();
    secondsLeft = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        secondsLeft--;
        notifyListeners();
      } else {
        timer.cancel();
        onTimeout();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  void resetTimer() {
    secondsLeft = 10;
    notifyListeners();
  }

  void selectOption(int index) {
    if (answered) return;
    selectedOption = index;
    answered = true;

    if (index == quizQuestions[currentQuestionIndex].correctIndex) {
      score += 10;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (currentQuestionIndex < quizQuestions.length - 1) {
      currentQuestionIndex++;
      selectedOption = null;
      answered = false;
      secondsLeft = 10;
      notifyListeners();
    } else {
      stopTimer();
    }
  }

  void resetQuiz() {
    currentQuestionIndex = 0;
    selectedOption = null;
    answered = false;
    secondsLeft = 10;
    score = 0;
    stopTimer();
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!_isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _timer?.cancel();
    super.dispose();
  }
}
