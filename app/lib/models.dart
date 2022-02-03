class Game {
  final int id;
  final String name;
  final List<String> screenshots;
  final List<String> alternativeNames;

  Game({
    required this.id,
    required this.name,
    required this.screenshots,
    required this.alternativeNames,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    List<dynamic> screenshots = json['screenshots'];
    List<String> screenshotsList =
        screenshots.map((dynamic s) => s as String).toList();
    List<dynamic> alternativeNames = json['alternative_names'];
    List<String> alternativeNamesList =
        alternativeNames.map((dynamic s) => s as String).toList();
    return Game(
      id: json['id'],
      name: json['name'],
      screenshots: screenshotsList,
      alternativeNames: alternativeNamesList,
    );
  }
}
