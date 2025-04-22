import 'package:flutter/material.dart';
import 'package:hand_cricket/data/models/game_state_model.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';

class GameProvider with ChangeNotifier {
  GameRepository gameRepository;

  GameState _state;

  GameProvider({required this.gameRepository})
    : _state = gameRepository.resetGame();

  GameState get state => _state;

  Future<void> playerChooses(int number) async {
    if (_state.phase == GamePhase.gameOver) return;

    // update player choice
    _state = GameStateModel.fromEntity(
      _state,
    ).copyWith(player: _state.player.copyWith(currentChoice: number));

    // get bot choice
    final botChoice = await gameRepository.getBotChoice();

    // update bot choice
    _state = GameStateModel.fromEntity(
      _state,
    ).copyWith(bot: _state.bot.copyWith(currentChoice: botChoice));

    // evaluate outcome of this state
    _state = gameRepository.evaluateOutcome(_state);
    notifyListeners();
  }

  void reset() {
    _state = gameRepository.resetGame();
    notifyListeners();
  }
}
