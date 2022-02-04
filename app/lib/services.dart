import 'dart:convert';
import 'package:http/http.dart';
import 'models.dart';

class HttpService {
  final Uri gameURL = Uri.parse(
      "https://us-central1-namethegame-1583939560192.cloudfunctions.net/api/game");

  Future<Game> getGame() async {
    Response res = await get(gameURL);

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      Game game = Game.fromJson(body);

      return game;
    } else {
      throw "Unable to retrieve game.";
    }
  }
}
