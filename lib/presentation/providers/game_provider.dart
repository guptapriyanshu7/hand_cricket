import 'package:flutter/material.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/usecases/evaluate_outcome.dart';
import 'dart:async';

import 'package:hand_cricket/domain/usecases/get_bot_choice.dart';
import 'package:hand_cricket/domain/usecases/reset_game.dart';

// the provider to connect the UI with the game logic
class GameProvider with ChangeNotifier {
  final GetBotChoice getBotChoice;
  final EvaluateOutcome evaluateOutcome;
  final ResetGame resetGame;

  Timer? _timer;
  static const int timeLimit = 10;
  int _remainingTime = timeLimit;
  bool _triggerAnimation = false;

  GameState _state;

  GameProvider({
    required this.getBotChoice,
    required this.evaluateOutcome,
    required this.resetGame,
  }) : _state = resetGame() {
    _startTimer();
  }

  GameState get state => _state;
  int get remainingTime => _remainingTime;
  bool get triggerAnimation => _triggerAnimation;

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
        playerTimedOut: true,
      );
      _timer?.cancel();
      notifyListeners();
    }
  }

  void playerChooses(int number) {
    if (_state.phase == GamePhase.gameOver) return;

    // Reset timer on valid choice
    _startTimer();

    // update player choice
    _state = _state.copyWith(
      player: _state.player.copyWith(currentChoice: number),
    );

    // get bot choice
    final botChoice = getBotChoice();

    // update bot choice
    _state = _state.copyWith(
      bot: _state.bot.copyWith(currentChoice: botChoice),
    );

    _triggerAnimation = true;
    // evaluate outcome of this state
    _state = evaluateOutcome(_state);

    if (_state.phase == GamePhase.gameOver) {
      _timer?.cancel();
    }

    notifyListeners();

    Future.delayed(const Duration(milliseconds: 800), () {
      _triggerAnimation = false;
      notifyListeners();
    });
  }

  void reset() {
    _state = resetGame();
    _startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
