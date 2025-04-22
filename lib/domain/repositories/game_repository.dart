// in the clean architecture we declare the repository interface for the data layer to implement how they want to populate/calculate that data
// here we are only getting/declaring the business requirements

import 'package:hand_cricket/domain/entities/game_state.dart';

// in this game we are calculating scores using hand gestures the one with the higher score wins
// so the repository will be responsible for handling the game state (start game, reset game, pause game, etc)
// and evaluating the outcome of the game (who has the higher score and consequently who wins)
// and getting the bot's choice adding here because other than random, bot choice could come from various local or remote sources
abstract class GameRepository {
  GameState evaluateOutcome(GameState currentState);
  GameState resetGame();
  int getBotChoice();
}
