import 'package:flutter/material.dart';
import 'services.dart';
import 'models.dart';
import "dart:math";
import 'utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

Future main() async {
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final HttpService _httpService = HttpService();
  late Game _game;
  bool _isLoading = true;
  final _random = Random();
  final _fieldController = TextEditingController();

  void pickGame() async {
    setState(() {
      _isLoading = true;
    });
    final Game game = await _httpService.getGame();
    setState(() {
      _game = game;
      _isLoading = false;
    });
  }

  void guessGame(String value) {
    List<String> names = [_game.name, ..._game.alternativeNames];
    bool win = names.any((String name) =>
        similarity(value.toUpperCase(), _game.name.toUpperCase()) > 0.5);
    if (win) {
      Fluttertoast.showToast(
          msg: "Correct!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      pickGame();
    } else {
      Fluttertoast.showToast(
          msg: "Wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    _fieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
                height: 200,
                color: Colors.black,
                child: Stack(children: [
                  Image.asset('assets/pickgame.gif'),
                  _isLoading
                      ? Container()
                      : Image.network(_game.screenshots[
                          _random.nextInt(_game.screenshots.length)]),
                ])),
            TextFormField(
              controller: _fieldController,
              decoration: const InputDecoration(
                labelText: 'Name your game',
              ),
              onFieldSubmitted: guessGame,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Guess Game'),
                  onPressed: () => guessGame(_fieldController.text),
                ),
                ElevatedButton(
                    onPressed: pickGame, child: const Text('Skip Game')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
