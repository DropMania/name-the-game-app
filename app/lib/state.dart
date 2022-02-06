import 'package:flutter/cupertino.dart';
import 'firebase.dart';
import 'models.dart';
import 'dart:math';
import 'dart:async';

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
  late Timer timer = Timer(const Duration(seconds: 0), () {});

  startTimer() {
    if (timer.isActive) {
      timer.cancel();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  pickGame() async {
    isLoading = true;
    notifyListeners();
    currentGame = await FBFunctions.getGame();
    playedGames.add(currentGame);
    currentScreenshot = currentGame
        .screenshots[_random.nextInt(currentGame.screenshots.length)];
    isLoading = false;
    notifyListeners();
  }

  increaseScore() {
    score += scoreIncrease;
    if (score > highScore) {
      highScore = score;
    }
    notifyListeners();
  }

  changeTime(int time) {
    timeLeft += time;
    if (timeLeft > maxTime) {
      timeLeft = maxTime;
    }
    notifyListeners();
  }

  increaseTime() {
    timeLeft += timeLeftIncrease;
    if (timeLeft > maxTime) {
      timeLeft = maxTime;
    }
    notifyListeners();
  }

  setLetter(String letter) {
    currentText += letter;
    notifyListeners();
  }

  backLetter() {
    if (currentText.isEmpty) return;
    currentText = currentText.substring(0, currentText.length - 1);
    notifyListeners();
  }

  clearText() {
    currentText = '';
    notifyListeners();
  }
}
