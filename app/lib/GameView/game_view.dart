import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state.dart';
import 'input_section.dart';
import 'score_section.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<GameState>();
    state.startTimer();
    return Scaffold(
      appBar: AppBar(
        title: const Text('NameTheGame'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/pickgame.gif',
                  fit: BoxFit.cover,
                ),
                state.isLoading
                    ? Container()
                    : Image.network(
                        state.currentScreenshot,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
            const ScoreSection(),
            const InputSection(),
          ],
        ),
      ),
    );
  }
}
