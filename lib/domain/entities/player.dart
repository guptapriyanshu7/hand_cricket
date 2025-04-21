// the essential fields of a player in the game state will be
// their score, whether they have batted (out or not) and their current choice (random if this is the bot)
class Player {
  final String name;
  final int score;
  final bool isOut;
  final int currentChoice;

  const Player({
    required this.name,
    this.score = 0,
    this.isOut = false,
    this.currentChoice = 0,
  });

  Player copyWith({String? name, int? score, bool? isOut, int? currentChoice}) {
    return Player(
      name: name ?? this.name,
      score: score ?? this.score,
      isOut: isOut ?? this.isOut,
      currentChoice: currentChoice ?? this.currentChoice,
    );
  }
}
