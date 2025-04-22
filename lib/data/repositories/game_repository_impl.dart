import 'package:hand_cricket/data/datasources/local/game_local_data_source.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/entities/player.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameLocalDataSource localDataSource;

  GameRepositoryImpl({required this.localDataSource});

  @override
  Future<int> getBotChoice() async {
    return localDataSource.getRandomNumber(1, 6);
  }

  @override
  GameState evaluateOutcome(GameState currentState) {
    throw UnimplementedError('evaluateOutcome is not implemented yet');
  }

  @override
  GameState resetGame() {
    return GameState(
      player: const Player(name: 'You'),
      bot: const Player(name: 'Bot'),
      phase: GamePhase.playerBatting,
    );
  }
}
