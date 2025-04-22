import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';

class EvaluateOutcome {
  final GameRepository repository;

  EvaluateOutcome(this.repository);

  GameState call(GameState currentState) {
    return repository.evaluateOutcome(currentState);
  }
}
