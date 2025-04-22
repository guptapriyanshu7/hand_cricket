import 'dart:math';

class GameLocalDataSource {
  Future<int> getRandomNumber(int min, int max) async {
    return Random().nextInt(max - min + 1) + min;
  }
}
