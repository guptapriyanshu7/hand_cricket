import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/entities/player.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  @override
  GameState evaluateOutcome(GameState currentState) {
    switch (currentState.phase) {
      case GamePhase.playerBatting:
        return _evaluatePlayerBattingOutcome(currentState);
      case GamePhase.botBatting:
        return _evaluateBotBattingOutcome(currentState);
      default:
        return currentState;
    }
  }

  GameState _evaluatePlayerBattingOutcome(GameState currentState) {
    final player = currentState.player;
    final bot = currentState.bot;
    final ballsRemaining = currentState.ballsRemaining;
    final nextBallsRemaining = ballsRemaining - 1;

    // if the player is out
    if (player.currentChoice == bot.currentChoice) {
      return currentState.copyWith(
        player: player.copyWith(isOut: true),
        phase: GamePhase.botBatting, // switch to bot's turn
        ballsRemaining: 6, // reset balls for the next innings
      );
    }

    // player is not out, so they score runs
    final newPlayerScore = player.score + player.currentChoice;
    final newPlayerRunHistory = [...player.runHistory, player.currentChoice];

    // check if this was the last ball of the player's innings
    final bool inningsOver = nextBallsRemaining == 0;

    return currentState.copyWith(
      player: player.copyWith(
        score: newPlayerScore,
        runHistory: newPlayerRunHistory,
      ),
      // if innings are over, switch phase and reset balls; otherwise, just decrement balls.
      phase: inningsOver ? GamePhase.botBatting : currentState.phase,
      ballsRemaining: inningsOver ? 6 : nextBallsRemaining,
    );
  }

  GameState _evaluateBotBattingOutcome(GameState currentState) {
    final player = currentState.player;
    final bot = currentState.bot;
    final ballsRemaining = currentState.ballsRemaining;
    final nextBallsRemaining = ballsRemaining - 1;

    // check if the bot is out
    if (player.currentChoice == bot.currentChoice) {
      // bot is out, game over
      return currentState.copyWith(
        bot: bot.copyWith(isOut: true),
        phase: GamePhase.gameOver,
        ballsRemaining: nextBallsRemaining, // record the ball was bowled
      );
    }

    // bot is not out, so they score runs
    final newBotScore = bot.score + bot.currentChoice;
    final newBotRunHistory = [...bot.runHistory, bot.currentChoice];

    final bool inningsOver = nextBallsRemaining == 0;

    // determine if the game ends after this ball
    final bool botWins = newBotScore > player.score;
    final bool gameOver = botWins || inningsOver;

    return currentState.copyWith(
      bot: bot.copyWith(score: newBotScore, runHistory: newBotRunHistory),
      // if game is over (win or last ball), change phase; otherwise, keep bot batting.
      phase: gameOver ? GamePhase.gameOver : currentState.phase,
      ballsRemaining:
          nextBallsRemaining, // Always decrement for bot's innings until game over
    );
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
