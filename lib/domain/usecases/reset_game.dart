import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';

class ResetGame {
  final GameRepository repository;

  ResetGame(this.repository);

  GameState call() {
    return repository.resetGame();
  }
}
