import 'package:flutter/material.dart';
import '../state.dart';
import 'package:provider/provider.dart';
import '../utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InputSection extends StatelessWidget {
  const InputSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GameState state = Provider.of<GameState>(context);
    void guessGame() {
      if (state.currentText == '') return;
      List<String> names = [
        state.currentGame.name,
        ...state.currentGame.alternativeNames
      ];
      bool win = names.any((String name) =>
          similarity(state.currentText.toUpperCase(), name.toUpperCase()) >
          0.5);
      if (win) {
        Fluttertoast.showToast(
            msg: 'Correct!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        state.increaseScore();
        state.increaseTime();
        state.pickGame();
      } else {
        Fluttertoast.showToast(
            msg: 'Wrong!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      state.clearText();
    }

    return Column(
      children: [
        Text(
          state.currentText,
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Guess Game'),
              onPressed: guessGame,
            ),
            ElevatedButton(
                onPressed: state.pickGame, child: const Text('Skip Game')),
          ],
        ),
        const KeyBoard()
      ],
    );
  }
}

class KeyBoard extends StatelessWidget {
  const KeyBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<GameState>(context);
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 1; i < 10; i++) KeyButton(text: i.toString()),
              const KeyButton(text: '0'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              KeyButton(text: 'Q'),
              KeyButton(text: 'W'),
              KeyButton(text: 'E'),
              KeyButton(text: 'R'),
              KeyButton(text: 'T'),
              KeyButton(text: 'Y'),
              KeyButton(text: 'U'),
              KeyButton(text: 'I'),
              KeyButton(text: 'O'),
              KeyButton(text: 'P'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              KeyButton(text: 'A'),
              KeyButton(text: 'S'),
              KeyButton(text: 'D'),
              KeyButton(text: 'F'),
              KeyButton(text: 'G'),
              KeyButton(text: 'H'),
              KeyButton(text: 'J'),
              KeyButton(text: 'K'),
              KeyButton(text: 'L'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              KeyButton(text: 'Z'),
              KeyButton(text: 'X'),
              KeyButton(text: 'C'),
              KeyButton(text: 'V'),
              KeyButton(text: 'B'),
              KeyButton(text: 'N'),
              KeyButton(text: 'M'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => state.addLetter('-'),
                child: const Text('-'),
              ),
              ElevatedButton(
                onPressed: () => state.addLetter(' '),
                child: const Text(' '),
              ),
              ElevatedButton(
                  onPressed: state.backLetter,
                  onLongPress: state.clearText,
                  child: const Text('<-')),
            ],
          ),
        ],
      ),
    );
  }
}

class KeyButton extends StatelessWidget {
  const KeyButton({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<GameState>(context);
    return SizedBox(
      height: 60,
      width: 36,
      child: ElevatedButton(
        onPressed: () => state.addLetter(text),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.black,
              width: 3,
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
