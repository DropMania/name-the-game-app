import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'state.dart';
import 'GameView/game_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Directionality(
              child: Text('Error'), textDirection: TextDirection.ltr);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: appTheme,
              home: ChangeNotifierProvider(
                create: (context) => GameState(),
                child: const GameView(),
              ));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Directionality(
            child: Text('loading'), textDirection: TextDirection.ltr);
      },
    );
  }
}
