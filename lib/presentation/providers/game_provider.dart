import 'package:flutter/material.dart';
import 'package:hand_cricket/data/models/game_state_model.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/repositories/game_repository.dart';
import 'dart:async';

class GameProvider with ChangeNotifier {
  GameRepository gameRepository;
  Timer? _timer;
  static const int timeLimit = 10;
  int _remainingTime = timeLimit;

  GameState _state;

  GameProvider({required this.gameRepository})
      : _state = gameRepository.resetGame() {
    _startTimer();
  }

  GameState get state => _state;
  int get remainingTime => _remainingTime;

  void _startTimer() {
    _remainingTime = timeLimit;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _handleTimeout();
      }
    });
  }

  void _handleTimeout() {
    if (_state.phase != GamePhase.gameOver) {
      _state = GameState(
        player: _state.player.copyWith(isOut: true),
        bot: _state.bot,
        phase: GamePhase.gameOver,
      );
      _timer?.cancel();
      notifyListeners();
    }
  }

  Future<void> playerChooses(int number) async {
    if (_state.phase == GamePhase.gameOver) return;

    // Reset timer on valid choice
    _startTimer();

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
    _startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
