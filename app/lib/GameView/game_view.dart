import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state.dart';
import 'input_section.dart';
import 'score_section.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timestamp) {
      GameState state = Provider.of<GameState>(context, listen: false);
      state.startTimer();
      state.pickGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    GameState state = Provider.of<GameState>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 64, 8, 8),
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
