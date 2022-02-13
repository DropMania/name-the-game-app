import 'package:flutter/cupertino.dart';
import 'firebase.dart';
import 'models.dart';
import 'dart:math';
import 'package:pausable_timer/pausable_timer.dart';

class GameState extends ChangeNotifier {
  late Game currentGame;
  final List<Game> playedGames = [];
  String currentScreenshot = '';
  String currentText = '';
  bool isLoading = true;
  int score = 0;
  int highScore = 0;
  int scoreIncrease = 100;
  int maxTime = 60;
  int timeLeft = 60;
  int timeLeftIncrease = 5;
  final _random = Random();
  late final PausableTimer _timer =
      PausableTimer(const Duration(seconds: 1), timerTick);

  /// starts the timer
  void startTimer() {
    _timer.start();
  }

  void timerTick() {
    if (timeLeft > 0) {
      timeLeft--;
      _timer
        ..reset()
        ..start();
      notifyListeners();
    }
  }

  /// picks a random game from igdb
  void pickGame() async {
    isLoading = true;
    _timer.pause();
    notifyListeners();
    currentGame = await FBFunctions.getGame();
    playedGames.add(currentGame);
    currentScreenshot = currentGame
        .screenshots[_random.nextInt(currentGame.screenshots.length)];
    isLoading = false;
    _timer.start();
    notifyListeners();
  }

  /// increases the score by the [scoreIncrease]
  void increaseScore() {
    score += scoreIncrease;
    if (score > highScore) {
      highScore = score;
    }
    notifyListeners();
  }

  /// changes the time left by the given amount
  void changeTime(int time) {
    timeLeft += time;
    if (timeLeft > maxTime) {
      timeLeft = maxTime;
    }
    notifyListeners();
  }

  /// increases the time left by [timeLeftIncrease] seconds.
  void increaseTime() {
    timeLeft += timeLeftIncrease;
    if (timeLeft > maxTime) {
      timeLeft = maxTime;
    }
    notifyListeners();
  }

  /// adds the string to the current game's text
  void addLetter(String letter) {
    currentText += letter;
    notifyListeners();
  }

  /// removes the last letter from the current game's text
  void backLetter() {
    if (currentText.isEmpty) return;
    currentText = currentText.substring(0, currentText.length - 1);
    notifyListeners();
  }

  /// clears the current game's text
  void clearText() {
    currentText = '';
    notifyListeners();
  }
}
