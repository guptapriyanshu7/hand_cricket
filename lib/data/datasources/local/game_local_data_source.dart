import 'dart:math';

abstract class GameLocalDataSource {
  int getRandomNumber(int min, int max);
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  final Random _random = Random();

  @override
  int getRandomNumber(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }
}
