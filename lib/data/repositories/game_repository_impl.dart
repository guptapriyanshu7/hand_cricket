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
    final player = currentState.player;
    final bot = currentState.bot;
    var phase = currentState.phase;
    var ballsRemaining = currentState.ballsRemaining;

    // first we check who is currently batting
    if (phase == GamePhase.playerBatting) {
      // if the choices match, the player is out
      if (player.currentChoice == bot.currentChoice) {
        // emit a new state with the player out
        return currentState.copyWith(
          player: player.copyWith(isOut: true),
          phase: GamePhase.botBatting,
          ballsRemaining: 6,
        );
      } else if (ballsRemaining > 1) {
        // if balls remaining, continue batting qnd add to score
        return currentState.copyWith(
          player: player.copyWith(score: player.score + player.currentChoice),
          ballsRemaining: ballsRemaining - 1,
        );
      } else {
        // if no balls left, innings over, switch to bot batting
        return currentState.copyWith(
          player: player.copyWith(score: player.score + player.currentChoice),
          phase: GamePhase.botBatting,
          ballsRemaining: 6,
        );
      }
    } else if (phase == GamePhase.botBatting) {
      if (player.currentChoice == bot.currentChoice) {
        // if bot's choice match
        return currentState.copyWith(
          bot: bot.copyWith(isOut: true),
          phase: GamePhase.gameOver,
        );
      } else if (bot.score + bot.currentChoice > player.score) {
        // bot wins by surpassing player's score
        return currentState.copyWith(
          bot: bot.copyWith(score: bot.score + bot.currentChoice),
          phase: GamePhase.gameOver,
        );
      } else if (ballsRemaining > 1) {
        // bot continues batting
        return currentState.copyWith(
          bot: bot.copyWith(score: bot.score + bot.currentChoice),
          ballsRemaining: ballsRemaining - 1,
        );
      } else {
        // game over - last ball played
        return currentState.copyWith(
          bot: bot.copyWith(score: bot.score + bot.currentChoice),
          phase: GamePhase.gameOver,
        );
      }
    }

    return currentState;
  }

  @override
  GameState resetGame() {
    return const GameState(
      player: Player(name: 'You'),
      bot: Player(name: 'Bot'),
      phase: GamePhase.playerBatting,
    );
  }
}
