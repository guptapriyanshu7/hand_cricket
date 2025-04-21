// we are starting with the most basic thing of this application
// the game state
// any game devlopment will start with the game state

import 'package:hand_cricket/domain/entities/player.dart';

// for our faily simple state we have only 3 things -> active (player or bot batting), game over
enum GamePhase { playerBatting, botBatting, gameOver }

// at any instance if we pause the app what should we have on screen
// 1. 2 players batting or bowling (who or none is batting handled by the phase enum)
// 2. the balls remaining (until the player is out or 6 balls are bowled)
class GameState {
  final Player player;
  final Player bot;
  final GamePhase phase;
  final int ballsRemaining;

  const GameState({
    required this.player,
    required this.bot,
    required this.phase,
    this.ballsRemaining = 6,
  });
}
