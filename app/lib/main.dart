import 'package:flutter/material.dart';
import 'services.dart';
import 'models.dart';
import "dart:math";
import 'utils.dart';

void main() {
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
    double sim = similarity(value, _game.name);
    if (sim > 0.5) {
      print('You win!');
      pickGame();
    }
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
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Image.network(_game
                      .screenshots[_random.nextInt(_game.screenshots.length)]),
            ),
            TextFormField(
              controller: _fieldController,
              decoration: const InputDecoration(
                labelText: 'Name your game',
              ),
              onFieldSubmitted: guessGame,
            ),
            ElevatedButton(onPressed: pickGame, child: const Text('Pick Game'))
          ],
        ),
      ),
    );
  }
}
