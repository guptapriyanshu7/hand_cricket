import 'dart:math';

// breaking into abstract class and then implementing it
abstract class GameLocalDataSource {
  int getRandomNumber();
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  final Random _random = Random();

  @override
  int getRandomNumber() {
    // since the player would want to score big numbers, so giving big weights to them
    final weightedList = <int>[
      1, 1, //
      2, 2, //
      3, 3, 3, //
      4, 4, 4, 4, //
      5, 5, 5, 5, //
      6, 6, 6, 6, //
    ];

    return weightedList[_random.nextInt(weightedList.length)];
  }
}
