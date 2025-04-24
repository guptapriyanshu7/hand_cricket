import 'package:flutter/material.dart';
import 'package:hand_cricket/domain/entities/game_state.dart';
import 'package:hand_cricket/domain/usecases/evaluate_outcome.dart';
import 'dart:async';

import 'package:hand_cricket/domain/usecases/get_bot_choice.dart';
import 'package:hand_cricket/domain/usecases/reset_game.dart';

enum OverlayEvent { none, playerSix, playerBattingStart, playerOut, playerDefend }

class GameProvider with ChangeNotifier {
  final GetBotChoice getBotChoice;
  final EvaluateOutcome evaluateOutcome;
  final ResetGame resetGame;

  Timer? _timer;
  static const int timeLimit = 10;
  int _remainingTime = timeLimit;

  GameState _state;

  OverlayEvent _overlayEvent = OverlayEvent.none;
  String? _overlayData;

  GameProvider({
    required this.getBotChoice,
    required this.evaluateOutcome,
    required this.resetGame,
  }) : _state = resetGame() {
    _startTimer();
  }

  GameState get state => _state;
  int get remainingTime => _remainingTime;

  // exposes the current overlay event, then resets it when read
  OverlayEvent get overlayEvent {
    final e = _overlayEvent;
    _overlayEvent = OverlayEvent.none;
    return e;
  }

  String? get overlayData {
    final d = _overlayData;
    _overlayData = null;
    return d;
  }

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

    _state = _state.copyWith(
      player: _state.player.copyWith(currentChoice: number),
    );

    // get bot choice
    final botChoice = getBotChoice();

    // update bot choice
    _state = _state.copyWith(
      bot: _state.bot.copyWith(currentChoice: botChoice),
    );

    // evaluate outcome of this state
    _state = evaluateOutcome(_state);

    _handleOverlayEvents(number);

    if (_state.phase == GamePhase.gameOver) {
      _timer?.cancel();
    }

    notifyListeners();
  }

  void _handleOverlayEvents(int number) {
    if (_shouldShowPlayerSix(number)) {
      _overlayEvent = OverlayEvent.playerSix;
      return;
    }
    if (_shouldShowBattingStart()) {
      _overlayEvent = OverlayEvent.playerBattingStart;
      return;
    }
    if (_isBotInningsStart()) {
      _handleBotBattingEvents(number);
    }
  }

  bool _shouldShowPlayerSix(int number) {
    return _state.phase == GamePhase.playerBatting && number == 6;
  }

  bool _shouldShowBattingStart() {
    return _state.phase == GamePhase.playerBatting &&
        _state.ballsRemaining == 6;
  }

  bool _isBotInningsStart() {
    return _state.phase == GamePhase.botBatting && _state.ballsRemaining == 6;
  }

  void _handleBotBattingEvents(int number) {
    if (_state.player.isOut) {
      _overlayEvent = OverlayEvent.playerOut;
    } else if (number == 6) {
      _overlayEvent = OverlayEvent.playerSix;
    }
    final delay =
        _state.player.isOut || number == 6
            ? const Duration(milliseconds: 1200)
            : Duration.zero;
    Future.delayed(delay, () {
      _overlayEvent = OverlayEvent.playerDefend;
      _overlayData = _state.player.score.toString();
      notifyListeners();
    });
  }

  void reset() {
    _state = resetGame();
    _overlayEvent = OverlayEvent.none;
    _overlayData = null;
    _startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
