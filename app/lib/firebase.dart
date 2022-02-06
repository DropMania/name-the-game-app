import 'package:cloud_functions/cloud_functions.dart';
import 'models.dart';

class FBFunctions {
  static Future<Map<String, dynamic>> callFunction(
      String functionName, Map<String, dynamic> params) async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      functionName,
    );
    final HttpsCallableResult result = await callable.call(params);
    final Map<String, dynamic> data = result.data;
    return data;
  }

  static Future<Game> getGame() async {
    final Map<String, dynamic> data = await callFunction(
      'game',
      {},
    );
    return Game.fromJson(data);
  }
}
