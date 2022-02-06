import 'package:app/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state.dart';

class ScoreSection extends StatelessWidget {
  const ScoreSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<GameState>();

    return Column(
      children: [
        SizedBox(
          height: 20,
          child: LinearProgressIndicator(
            value: state.timeLeft / state.maxTime,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        SizedBox(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15),
                color: Colors.red),
            child: Text(
              'Score: ${state.score}',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
      ],
    );
  }
}
