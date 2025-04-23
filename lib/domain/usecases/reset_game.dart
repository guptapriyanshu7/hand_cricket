import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';

// clean architecture use case for resetting the game
class ResetGame {
  final GameRepository repository;

  ResetGame(this.repository);

  GameState call() {
    return repository.resetGame();
  }
}
