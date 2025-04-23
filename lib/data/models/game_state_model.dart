import 'package:hand_cricket/domain/entities/game_state.dart';

class GameStateModel extends GameState {
  GameStateModel({
    required super.player,
    required super.bot,
    required super.phase,
    super.ballsRemaining,
    super.playerTimedOut,
  });

  factory GameStateModel.fromEntity(GameState entity) {
    return GameStateModel(
      player: entity.player,
      bot: entity.bot,
      phase: entity.phase,
      ballsRemaining: entity.ballsRemaining,
      playerTimedOut: entity.playerTimedOut,
    );
  }
}
