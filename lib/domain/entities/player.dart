// the essential fields of a player in the game state will be
// their score, whether they have batted (out or not) and their current choice (random if this is the bot)
// save a list of their run history
class Player {
  final String name;
  final int score;
  final bool isOut;
  final int currentChoice;
  final List<int> runHistory;

  const Player({
    required this.name,
    this.score = 0,
    this.isOut = false,
    this.currentChoice = 0,
    this.runHistory = const [],
  });

  Player copyWith({String? name, int? score, bool? isOut, int? currentChoice, List<int>? runHistory}) {
    return Player(
      name: name ?? this.name,
      score: score ?? this.score,
      isOut: isOut ?? this.isOut,
      currentChoice: currentChoice ?? this.currentChoice,
      runHistory: runHistory ?? this.runHistory,
    );
  }
}
